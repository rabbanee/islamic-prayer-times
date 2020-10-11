import 'package:flutter/material.dart';
import 'package:islamic_prayer_times/IslamicPrayerTimes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Islamic Prayer Times',
      home: IslamicPrayerTimes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
