import 'package:flutter/material.dart';
import 'package:fyp_pro/AlimDashboard/Screens/NavigationScreen.dart';
class AlimDashboardMain extends StatefulWidget {
  const AlimDashboardMain({super.key});

  @override
  State<AlimDashboardMain> createState() => _AlimDashboardMainState();
}

class _AlimDashboardMainState extends State<AlimDashboardMain> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:AlimBTNavbarMain(),

    );
  }
}
