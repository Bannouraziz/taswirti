import 'package:flutter/material.dart';
import 'package:taswirti/views/home.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:taswirti/AnalyticsService.dart';
void main() {
  final AnalyticsService analyticsService = AnalyticsService();
final FirebaseAnalyticsObserver observer = analyticsService.getAnalyticsObserver();

   WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp(observer: observer));

}

class MyApp extends StatelessWidget {
  final FirebaseAnalyticsObserver observer;

  const MyApp({Key? key, required this.observer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taswirti',
      navigatorObservers: [observer], // Add the observer to the navigatorObservers list
      home: Home(),
    );
  }
}

