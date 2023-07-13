import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
class AnalyticsService {
  static FirebaseAnalytics _analytics = FirebaseAnalytics.instance; 
  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);
}
