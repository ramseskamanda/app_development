import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:studentup/ui/onboarding/page_template.dart';
//import 'package:studentup/router.dart';
//import 'package:studentup/util/env.dart';

class Onboarding extends StatelessWidget {
  final pages = [
    PageTemplate(
      brightness: Brightness.dark,
      imageUrl:
          'https://onlinejpgtools.com/images/examples-onlinejpgtools/random-grid.jpg',
      text: 'An amazing platform!',
    ),
    PageTemplate(
      brightness: Brightness.light,
      imageUrl: 'https://via.placeholder.com/250',
      text: 'Great features!',
    ),
    PageTemplate(
      brightness: Brightness.dark,
      imageUrl: 'https://via.placeholder.com/250',
      text: 'User-oriented Interactivity!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: LiquidSwipe(
        key: key,
        pages: pages,
      ),
    );
  }
}
