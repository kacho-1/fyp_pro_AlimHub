import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';

class Constants{
  static const kPrimary = TColors.primary;
  static const MaterialColor KSwatchColor = const MaterialColor(
    0xFF42A5F5, // Base color
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5), // Same as the base color
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
  static int? juzIndex;
  static int? surahIndex;
}