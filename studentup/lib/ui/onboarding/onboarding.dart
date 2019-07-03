import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:studentup/router.dart';
import 'package:studentup/util/env.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageViewModel _welcome = PageViewModel(
      pageColor: Colors.lightGreen,
      mainImage: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.white,
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: const Text('Welcome'),
      ),
      body: const Text(
        'Welcome to ${Environment.appName}. The app ${Environment.slogan}',
      ),
    );

    PageViewModel _introduction = PageViewModel(
      pageColor: Colors.green,
      mainImage: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.white,
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: const Text('Your Career'),
      ),
      body: const Text(
        'Take initiative and become successful through our platform!',
      ),
    );

    PageViewModel _final = PageViewModel(
      pageColor: Colors.lightGreen,
      mainImage: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.white,
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: const Text('First Step'),
      ),
      body: const Text(
        'Just register with a student email and you\'re ready to go!',
      ),
    );

    _goToSignUp() =>
        Navigator.of(context).pushReplacementNamed(Router.signupRoute);

    return Builder(
      builder: (context) {
        return IntroViewsFlutter(
          [
            _welcome,
            _introduction,
            _final,
          ],
          onTapDoneButton: _goToSignUp,
          onTapSkipButton: _goToSignUp,
          showSkipButton: true,
          showBackButton: true,
          showNextButton: true,
          background: Colors.lightGreen,
        );
      },
    );
  }
}
