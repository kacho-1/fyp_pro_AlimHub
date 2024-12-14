import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Dua/dua.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/Courses.dart';
import 'package:fyp_pro/CommonFeatures/PrayerTiming/PrayerScreen.dart';
import 'package:fyp_pro/CommonFeatures/Quran/QuranMainScreen.dart';
import '../../publicdashboard/ConsultancySystem/on/Widget/bottomnavbar.dart';
import '../CommunityForum/Main/main_screen.dart';
import '../Qiblah/Qiblah.dart';
import 'CustomIconButton.dart';
import 'package:fyp_pro/publicdashboard/Tasbih/tashbih.dart';

class CAppPortion extends StatefulWidget {
  const CAppPortion({super.key});
  @override
  State<CAppPortion> createState() => _CAppPortionState();
}

class _CAppPortionState extends State<CAppPortion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        shrinkWrap: true, // Ensures GridView fits within ListView
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
        children: [
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/fatwa.svg',
            text: 'Fatwa',
            onPressed: () {
              // Navigate to Fatwa screen or any other action
              print('Fatwa Button Pressed!');
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/alim.svg',
            text: 'Alim',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BTNavBar()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/community.svg',
            text: 'Community',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PostMainScreen()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/tasbih.svg',
            text: 'Tasbih',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TisbahScreen()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/prayer_time.svg',
            text: 'Prayers',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PrayerScreen()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/duas.svg',
            text: 'Dua',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DuasScreen()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/quran.svg',
            text: 'Quran',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const QuranMainScreen()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/kiblat1.svg',
            text: 'Qiblah',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Qiblah()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/course.svg',
            text: 'Courses',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AlimHubApp())); // Adjust navigation for course selection
            },
          ),
        ],
      ),
    );
  }
}
