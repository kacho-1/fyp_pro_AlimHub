import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/PrayerTiming/PrayerScreen.dart';

class PrayertimeScreen extends StatefulWidget {
  const PrayertimeScreen({super.key});

  @override
  State<PrayertimeScreen> createState() => _PrayertimeScreenState();
}

class _PrayertimeScreenState extends State<PrayertimeScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:PrayerScreen(),
    );
  }
}
