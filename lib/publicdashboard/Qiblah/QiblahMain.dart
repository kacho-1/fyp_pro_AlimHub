import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Qiblah/Qiblah.dart';

class QiblahPublicScreen extends StatefulWidget {
  const QiblahPublicScreen({super.key});

  @override
  State<QiblahPublicScreen> createState() => _QiblahPublicScreenState();
}

class _QiblahPublicScreenState extends State<QiblahPublicScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Qiblah(),
    );
  }
}
