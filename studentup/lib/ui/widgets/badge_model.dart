class BadgeModel {
  final int _placement;
  final String _badgePhoto;

  BadgeModel({int ranking})
      : _placement = ranking,
        _badgePhoto = 'https://logo.clearbit.com/spotify.com';

  int get placement => _placement;
  String get photoUrl => _badgePhoto;
}
