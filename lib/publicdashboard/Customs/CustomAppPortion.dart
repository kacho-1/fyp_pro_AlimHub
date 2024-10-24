import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/CommunityForum.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/Main/main_screen.dart';
import 'package:fyp_pro/publicdashboard/Dua/dua.dart';
import 'package:fyp_pro/publicdashboard/IslamicCourses/Courses.dart';
import 'package:fyp_pro/publicdashboard/PrayerTiming/PrayerScreen.dart';
import 'package:fyp_pro/publicdashboard/Qiblah/Qiblah.dart';
import 'package:fyp_pro/publicdashboard/Quran/QuranMainScreen.dart';
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
        physics: NeverScrollableScrollPhysics(), // Disable inner scrolling
        children: [
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/fatwa.svg',
            text: 'Fatwa',
            onPressed: () {
              print('Fatwa Button Pressed!');
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/alim.svg',
            text: 'Alim',
            onPressed: () {

            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/community.svg',
            text: 'Community',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> PostMainScreen()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/tasbih.svg',
            text: 'Tasbih',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> TisbahScreen()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/prayer_time.svg',
            text: 'Prayers',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PrayerScreen()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/duas.svg',
            text: 'Dua',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>DuasScreen())
              );
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/quran.svg',
            text: 'Quran',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>QuranMainScreen())
              );
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/kiblat1.svg',
            text: 'Qiblah',
            onPressed: () {
             Navigator.push(context,
                 MaterialPageRoute(builder: (context)=>Qiblah()));
            },
          ),
          SvgTextButton(
            svgPath: 'assets/images/collection_icon/course.svg',
            text: 'Courses',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>AlimHubApp()));
            },
          ),
        ],
      ),

    );
  }
}
/*
class CAppPortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      theme: ThemeData(

      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Welcome to AlimHub.',style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
            color: Colors.white,
          fontStyle: FontStyle.italic
        ),),
      ),

      // The body should be wrapped in ListView for scrolling.
      body: ListView(
        children: [
          SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
              Positioned.fill(
              child: ClipRRect(
              borderRadius: BorderRadius.circular(15), // Apply the same border radius to the image
              child: Image.asset(
                'assets/images/bg.jfif', // Your image path
                fit: BoxFit.cover,
              ),
              ),
              ),

                  ListTile(

                    title: Text('Upcoming Prayer',style: TextStyle(
                        fontSize: 25),),
                    subtitle: Text('MAGHRIB - 7:05 PM',style: TextStyle(
                        fontSize: 25)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Dhul-Qi’dah 4, 1445 AH',style: TextStyle(
                          fontSize: 25,
                        ),),
                      ],
                    ),
                  ),
                  ],
              ),
            ),
          ),

          // Categories section in a Grid
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true, // Ensures GridView fits within ListView
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(), // Disable inner scrolling
              children: [
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/fatwa.svg',
                  text: 'Fatwa',
                  onPressed: () {
                    print('Fatwa Button Pressed!');
                  },
                ),
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/alim.svg',
                  text: 'Alim',
                  onPressed: () {
                    print('Alim Button Pressed!');
                  },
                ),
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/community.svg',
                  text: 'Community',
                  onPressed: () {
                    print('Community Button Pressed!');
                  },
                ),
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/tasbih.svg',
                  text: 'Tasbih',
                  onPressed: () {
                    print('Tasbih Button Pressed!');
                  },
                ),
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/prayer_time.svg',
                  text: 'Prayers',
                  onPressed: () {
                    print('Prayers Button Pressed!');
                  },
                ),
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/duas.svg',
                  text: 'Dua',
                  onPressed: () {
                    print('Dua Button Pressed!');
                  },
                ),
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/quran.svg',
                  text: 'Quran',
                  onPressed: () {
                    print('Quran Button Pressed!');
                  },
                ),
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/kiblat1.svg',
                  text: 'Qiblah',
                  onPressed: () {
                    print('Qiblah Button Pressed!');
                  },
                ),
                SvgTextButton(
                  svgPath: 'assets/images/collection_icon/course.svg',
                  text: 'Courses',
                  onPressed: () {
                    print('Courses Button Pressed!');
                  },
                ),
              ],
            ),
          ),

          // Announcement Section
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  'Webinar Today: 9:50 PM\nWomen Rights in Islam',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
            NavBar(),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar

     */
/* NavigationBar: BottomNavigationBar(

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category,color: Colors.black), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today,color: Colors.black), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.black,), label: 'Profile'),
        ],*//*

       */
/* currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },*//*

      //),
    );
  }
}
*/
