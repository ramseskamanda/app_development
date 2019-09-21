import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:studentup_mobile/enum/analytics_types.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  Future<void> initialize() async {
    await _analytics.logAppOpen();
    await toggleDebug(true);
  }

  FirebaseAnalytics get logger => _analytics;

  Future<void> toggleDebug(bool value) async {
    await _analytics.setAnalyticsCollectionEnabled(value);
  }

  Future<void> logSpecialEvent(AnalyticsType type) async {
    switch (type) {
      case AnalyticsType.TEST:
        print(type.toString());
        await _analytics.logEvent(
          name: 'test_event',
          parameters: <String, dynamic>{
            'hello': 'world',
          },
        );
        break;
      default:
    }
  }
}
