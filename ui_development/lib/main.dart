import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

AuthService authService = AuthService();

Future<void> main() async {
  await authService.initialize();
  runApp(
    StreamProvider<ProfileNotifier>(
      builder: (_) => authService.subject,
      child: MyApp(),
      catchError: (_, err) => null,
      updateShouldNotify: (a, b) => true,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, profile, child) {
        if (profile == null)
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: LoginPage(),
          );
        profile.fetchData();
        return ChangeNotifierProvider<ProfileNotifier>(
          builder: (_) => profile,
          child: child,
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ProfileNotifier>(
              builder: (context, profile, child) {
                if (profile.isLoading) return CircularProgressIndicator();
                return Text(profile.name);
              },
            ),
            RaisedButton(
              child: const Text('Logout'),
              onPressed: () => authService._logout(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: const Text('Login'),
          onPressed: () => authService._login(),
        ),
      ),
    );
  }
}

class ProfileNotifier extends ChangeNotifier {
  bool _isLoading = false;
  String _name;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String get name => _name;

  Future<void> fetchData() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    _name = 'Ramses Kamanda';
    isLoading = false;
  }
}

class AuthService {
  BehaviorSubject<ProfileNotifier> subject;

  initialize() async {
    final ProfileNotifier profile = await _autologin();
    subject = BehaviorSubject.seeded(profile);
    subject.listen((data) {}, onError: (err) {
      print(err);
      subject.close();
    });
  }

  _autologin() async {
    await Future.delayed(const Duration(seconds: 2));
    return Random().nextBool() ? ProfileNotifier() : null;
  }

  _login() async {
    await Future.delayed(const Duration(seconds: 2));
    subject.add(ProfileNotifier());
  }

  _logout() async {
    subject.add(null);
  }
}
