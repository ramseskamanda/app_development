import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:studentup_mobile/enum/login_types.dart';
import 'package:studentup_mobile/input_blocs/signup_form_bloc.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';

class AuthNotifier extends BaseNetworkNotifier {
  //TODO: maybe refactor for authentication routing to go by authtype first then by signup or not

  final BaseAuth auth = Locator.of<BaseAuth>();
  SignUpFormBloc bloc;

  //TODO: test if bloc is cleared after login attempt, the text stays but when edited disappears
  AuthNotifier() : bloc = SignUpFormBloc();

  Future<void> authenticate(
    AuthType authType,
    bool isSignup, {
    //if there's a bug it's here:)
    bool isStartup = false,
  }) async {
    isLoading = true;
    AuthStatus status;
    if (isSignup || authType == AuthType.google)
      status = await signup(authType, isStartup);
    else
      status = await login(authType);
    if (status.authenticated) {
      isLoadingWithoutNotifiers = false;
      auth.saveUserToDisk();
    } else {
      error = NetworkError(message: status.error);
      isLoading = false;
    }
  }

  @protected
  Future<AuthStatus> login(AuthType authType) async {
    switch (authType) {
      case AuthType.email:
        return await auth.loginWithEmail(
          email: bloc.emailValue,
          password: bloc.passwordValue,
        );
      case AuthType.google:
        return await auth.loginWithGoogle();
      default:
        return AuthStatus(
          authenticated: false,
          error: 'AuthType: $authType not supported yet',
        );
    }
  }

  @protected
  Future<AuthStatus> signup(AuthType authType, bool isStartup) async {
    AuthStatus status;
    switch (authType) {
      case AuthType.email:
        status = await auth.signUpWithEmail(
          email: bloc.emailValue,
          password: bloc.passwordValue,
        );
        break;
      case AuthType.google:
        status = await auth.loginWithGoogle();
        break;
    }

    if (!auth.currentUserisNew) return status;
    if (status.authenticated && isStartup)
      _signupStartup(authType);
    else if (status.authenticated && !isStartup) _signupUser(authType);

    return status;
  }

  @protected
  Future<void> _signupStartup(AuthType authType) async {
    StartupInfoModel model;
    if (authType == AuthType.google) {
      FirebaseUser user = auth.currentUser as FirebaseUser;
      model = StartupInfoModel(
        name: user.displayName,
        imageUrl: user.photoUrl,
        creation: DateTime.now(),
      );
    } else {
      model = StartupInfoModel(
        name: bloc.nameValue,
        imageUrl: null,
        creation: DateTime.now(),
      );
    }
    await Locator.of<BaseAPIWriter>().createStartup(auth.currentUserId, model);
  }

  @protected
  Future<void> _signupUser(AuthType authType) async {
    UserInfoModel model;
    if (authType == AuthType.google) {
      FirebaseUser user = auth.currentUser as FirebaseUser;
      model = UserInfoModel(
        givenName: user.displayName,
        mediaRef: user.photoUrl,
      );
    } else {
      model = UserInfoModel(
        givenName: bloc.nameValue,
        mediaRef: null,
      );
    }
    await Locator.of<BaseAPIWriter>().createUser(auth.currentUserId, model);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
