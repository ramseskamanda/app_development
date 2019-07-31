import 'package:flutter/material.dart';

List<BoxShadow> getSimpleBoxShadow({Color color}) {
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

final List<Color> medalColors = <Color>[
  Colors.transparent,
  Colors.yellow,
  Colors.grey,
  Colors.brown,
];
