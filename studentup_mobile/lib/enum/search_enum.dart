enum SearchCategory {
  ALL,
  ARTIFICIAL_INTELLIGENCE,
  ART,
  BLOCKCHAIN,
  CODING,
  DATA_SCIENCE,
  DESIGN,
  ENGINEERING,
  FINANCE,
  LAW,
  MANAGEMENT,
  MARKETING,
  MUSIC,
  WEB,
  OTHER,
}

String toString(SearchCategory category) {
  return category.toString().split('.')[1].splitMapJoin(
        '_',
        onMatch: (m) => ' ',
        onNonMatch: (n) => n[0].toUpperCase() + n.substring(1).toLowerCase(),
      );
}
