import 'package:flutter/foundation.dart';

class PrizeModel {
  final String name;
  final String imageUrl;
  final String description;
  final int ranking;

  PrizeModel({
    @required this.name,
    @required this.imageUrl,
    @required this.description,
    @required this.ranking,
  });
}
