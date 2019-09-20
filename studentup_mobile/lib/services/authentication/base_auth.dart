import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/services/analytics/analytics_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/util/config.dart';

abstract class BaseAuth {
  BehaviorSubject<ProfileNotifier> subject;
  String _currentUserId;
  Map<Object, String> get errorMap;
  Object get currentUser;
  Future<void> initialize();
  Future<void> attemptAutoLogin();
  Future<AuthStatus> signUpWithEmail(
      {@required String email, @required String password});
  Future<AuthStatus> loginWithEmail(
      {@required String email, @required String password});
  Future<AuthStatus> loginWithGoogle();
  Future<AuthStatus> logout();
  void dispose();

  bool _isNewUser = false;

  bool get currentUserisNew => _isNewUser;
  String get currentUserId => _currentUserId;

  set currentUserId(String value) {
    _currentUserId = value;
    subject.add(value == null ? null : ProfileNotifier(value));
  }

  void saveUserToDisk() {
    try {
      final String userID = currentUserId;
      if (userID == null || userID.isEmpty) return;
      final List<String> accounts = List<String>.from(
        Locator.of<LocalStorageService>().getFromDisk(ACCOUNTS_LIST) ?? [],
        growable: true,
      );
      print(accounts);
      if (accounts.contains(userID)) return;
      accounts.add(userID);
      Locator.of<LocalStorageService>().saveToDisk(ACCOUNTS_LIST, accounts);
      print(accounts);
    } catch (e) {
      print(currentUserId + ' produced error:\n');
      print(e.toString());
    }
  }

  Future<List<Preview>> getAccounts() async {
    try {
      final List<String> accounts = List<String>.from(
        Locator.of<LocalStorageService>().getFromDisk(ACCOUNTS_LIST) ?? [],
        growable: true,
      );
      print(accounts);
      final List<Preview> models =
          await Locator.of<BaseAPIReader>().fetchAllUserAccounts(accounts);
      models.sort((a, b) => a.givenName.compareTo(b.givenName));
      return models;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

class AuthStatus {
  final bool authenticated;
  final String error;
  AuthStatus({@required this.authenticated, this.error});
}

class FirebaseAuthService extends BaseAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Object get currentUser async => await _auth.currentUser();

  @override
  Future<void> initialize() async {
    final ProfileNotifier profile = await attemptAutoLogin();
    subject = BehaviorSubject.seeded(profile);
  }

  @override
  Future<ProfileNotifier> attemptAutoLogin() async {
    FirebaseUser current = await _auth.currentUser();
    _currentUserId = current?.uid;
    if (current != null) return ProfileNotifier(current.uid);
    return null;
  }

  @override
  Future<AuthStatus> loginWithEmail({String email, String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final bool isSignedUp =
          Locator.of<LocalStorageService>().getFromDisk(SIGNUP_STORAGE_KEY) ??
              false;
      if (!isSignedUp)
        Locator.of<LocalStorageService>().saveToDisk(SIGNUP_STORAGE_KEY, true);
      Locator.of<AnalyticsService>().logger.logLogin(loginMethod: 'Email');
      currentUserId = result.user.uid;

      return AuthStatus(authenticated: true);
    } on PlatformException catch (e) {
      return AuthStatus(
        authenticated: false,
        error: errorMap[e.code] ?? errorMap['default'],
      );
    } catch (err) {
      return AuthStatus(
        authenticated: false,
        error: err.toString(),
      );
    }
  }

  @override
  Future<AuthStatus> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      _isNewUser = result?.additionalUserInfo?.isNewUser ?? false;
      final bool isSignedUp =
          Locator.of<LocalStorageService>().getFromDisk(SIGNUP_STORAGE_KEY) ??
              false;
      if (!isSignedUp)
        Locator.of<LocalStorageService>().saveToDisk(SIGNUP_STORAGE_KEY, true);

      if (_isNewUser)
        Locator.of<AnalyticsService>().logger.logSignUp(signUpMethod: 'Google');
      Locator.of<AnalyticsService>().logger.logLogin(loginMethod: 'Google');

      currentUserId = result.user.uid;
      return AuthStatus(authenticated: true);
    } on PlatformException catch (e) {
      return AuthStatus(
        authenticated: false,
        error: errorMap[e.code] ?? errorMap['default'],
      );
    } catch (err) {
      return AuthStatus(
        authenticated: false,
        error: err.toString(),
      );
    }
  }

  @override
  Future<AuthStatus> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      currentUserId = null;
      return AuthStatus(authenticated: false);
    } catch (e) {
      return AuthStatus(
        authenticated: true,
        error: e.toString(),
      );
    }
  }

  @override
  Future<AuthStatus> signUpWithEmail({String email, String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        Locator.of<LocalStorageService>().saveToDisk(SIGNUP_STORAGE_KEY, true);
        Locator.of<AnalyticsService>().logger.logSignUp(signUpMethod: 'Email');
        _isNewUser = true;
        currentUserId = result.user.uid;
      }
      return AuthStatus(authenticated: true);
    } on PlatformException catch (e) {
      return AuthStatus(
        authenticated: false,
        error: errorMap[e.code] ?? errorMap['default'],
      );
    } catch (err) {
      return AuthStatus(
        authenticated: false,
        error: err.toString(),
      );
    }
  }

  @override
  void dispose() => subject.close();

  @override
  Map<Object, String> get errorMap {
    return <Object, String>{
      'default': 'Contact the Studentup Team.',
      'ERROR_INVALID_EMAIL': 'The email entered is invalid.',
      'ERROR_WRONG_PASSWORD': 'The password entered is invalid.',
      'ERROR_USER_NOT_FOUND': 'Your account could not be found.',
      'ERROR_USER_DISABLED': 'Your account has been temorarily disabled.',
      'ERROR_TOO_MANY_REQUESTS':
          'Too many requests. Please, contact the studentup team.',
      'ERROR_OPERATION_NOT_ALLOWED':
          'This account and password are not enabled.',
      'ERROR_INVALID_CREDENTIAL': 'The credentials used are invalid.',
      'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
          'This account exists with different credentials.',
      'ERROR_INVALID_ACTION_CODE': 'Invalid operation detected.',
      'ERROR_WEAK_PASSWORD': 'The password entered is not strong enough.',
      'ERROR_INVALID_EMAIL': 'The email used is not valid.',
      'ERROR_EMAIL_ALREADY_IN_USE': 'This email is already in use.',
    };
  }
}
