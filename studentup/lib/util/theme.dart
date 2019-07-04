import 'package:flutter/material.dart';

class AppTheme {
  ///Medal Colors throughout the application
  /// * 0: transparent 🚫
  /// * 1: gold 🥇
  /// * 2: silver 🥈
  /// * 3: bronze 🥉
  static const List<Color> medalColors = <Color>[
    Colors.transparent,
    Color(0xFFFFD700),
    Color(0xFFC0C0C0),
    Color(0xFFCD7F32),
  ];

  ///Material box shadow with solid background and color of the app
  ///Takes`Material.Color color 🎨` that will determine the color
  ///of the returned `BoxShadow`s
  static List<BoxShadow> getSimpleBoxShadow({Color color}) {
    return <BoxShadow>[
      BoxShadow(
        offset: Offset(0.0, 3.0),
        blurRadius: 0,
        spreadRadius: -2.0,
        color: color,
      ),
      BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 0,
        spreadRadius: 0.0,
        color: color,
      ),
      BoxShadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 0,
        spreadRadius: 0.0,
        color: color,
      ),
    ];
  }
}
