import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Quran/QuranMainScreen.dart';


class QuranPublicScreen extends StatefulWidget {
  const QuranPublicScreen({super.key});

  @override
  State<QuranPublicScreen> createState() => _QuranPublicScreenState();
}

class _QuranPublicScreenState extends State<QuranPublicScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuranMainScreen(),
    );
  }
}
