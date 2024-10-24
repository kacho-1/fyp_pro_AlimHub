import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/Quran/Juz/Juz.dart';
import 'package:fyp_pro/publicdashboard/Quran/Screens/Quran.dart';
import 'package:fyp_pro/publicdashboard/Quran/Screens/QuranAudio.dart';
import 'package:fyp_pro/publicdashboard/Quran/Surah/surah_detail.dart';



class QuranMainScreen extends StatefulWidget {
  const QuranMainScreen({super.key});

  @override
  State<QuranMainScreen> createState() => _QuranMainScreenState();
}

class _QuranMainScreenState extends State<QuranMainScreen> {
  int setectedindex =0;
  List<Widget> _widgetlist = [QuranScreen(),AudioQuranScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

          body: _widgetlist[setectedindex],
            bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(icon:Icons.menu_book_outlined,  title: 'Quran'),
                TabItem(icon: Icons.audiotrack , title: 'Audio'),

              ],
              initialActiveIndex: 0,
              onTap: UpdateIndex,
              backgroundColor: TColors.primary,
              activeColor: Colors.grey.shade200,
            )
        ),
    );
  }
  void UpdateIndex (index){
    setState(() {
      setectedindex=index;
    });
  }
}


