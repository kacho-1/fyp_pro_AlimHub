import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Screens/setting.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:iconsax/iconsax.dart';
import '../../CommonFeatures/CommunityForum/Main/main_screen.dart';
import '../../CommonFeatures/Customs/CustomAppbar.dart';
import '../../CommonFeatures/Customs/CustomColor.dart';
import '../../CommonFeatures/Customs/CustomContainier.dart';
import '../../CommonFeatures/Customs/CustomIconButton.dart';
import '../../CommonFeatures/PrayerTiming/PrayerScreen.dart';
import '../../CommonFeatures/Profile/Controller/Profilecontroller.dart';
import '../../CommonFeatures/Qiblah/Qiblah.dart';
import '../../CommonFeatures/Quran/QuranMainScreen.dart';
import '../../publicdashboard/Dua/dua.dart';
import '../../publicdashboard/Screens/HomeScreen.dart';
import '../../publicdashboard/Tasbih/tashbih.dart';

class AlimHomeScreen extends StatelessWidget {
  const AlimHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var hijra = HijriCalendar.now();
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title:  Center(
          child: Text('Welcome to Alim Dashboard',style: TextStyle(fontSize:
          16,fontWeight: FontWeight.bold,color: Colors.white),),

        ),
        backgroundColor: TColors.primary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // Custom drawer icon color
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: TColors.primary,
              ),
              child: Column(
                children: [
                  Text(
                    'Alim Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 18,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: ClipOval(
                          child: Obx(()=>CachedNetworkImage(
                            height: 80-12*2,
                            width: 80-12*2,
                            fit: BoxFit.cover,
                            imageUrl: controller.imageUrl.value,
                            placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/my.png'),
                          )),
                        ),
                        title: Obx(()=>Text(controller.name.value,
                          style: Theme.of(context).textTheme.headlineSmall!.apply(color:Colors.white),)),
                        subtitle:Text(controller.email.value,
                          style: Theme.of(context).textTheme.bodyMedium!.apply(color:Colors.grey.shade300),),
                      ),
                    ],
                  )
                ],
              )
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Fatwa'),
              onTap: () {
                // Navigate to the Scholar Upload Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Add Event'),
              onTap: () {
                // Navigate to the Create Event Screen


              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add'),
              onTap: () {
                // Navigate to the Create Event Screen


              },
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child:Column(
                  children: [
                    CAppBar(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Assalaam-Alaikum ',style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.white60,fontFamily: 'Poppins')),
                            Text('Kacho Kamran',style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.grey.shade300,fontFamily: 'Poppins-Medium',)),


                          ],
                        ),
                        actions: [
                          Stack(
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.notifications_rounded,color: Colors.white,)),
                                Positioned(
                                    right: 0,
                                    child:Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Text('2',style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white),),
                                      ),
                                    ) )
                              ] ),
                        ]

                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: TColors.textWhite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search,color: TColors.primary,),
                            SizedBox(width: 5,),
                            Text('Click her to Search',style: Theme.of(context).textTheme.bodySmall),

                          ],
                        ),

                      ),
                    ),
                    SizedBox(height: 14,),

                    ListTile(
                      title: Text('Upcoming Prayer',style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white)),
                      subtitle: Text(upcomingPrayer,style: Theme.of(context).textTheme.titleSmall!.apply(color: Colors.white)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Padding(padding: EdgeInsets.all(4),
                                      child: Text( hijra.hDay.toString(),
                                          style:Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white,

                                          ))),


                                ),
                                WidgetSpan(
                                  child: Padding(padding: EdgeInsets.all(4),

                                      child: Text(hijra.longMonthName,style:Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white,

                                      ))),

                                ),

                                WidgetSpan(
                                  child: Padding(padding: EdgeInsets.all(4),
                                    child: Text('${hijra.hYear} AH', style:Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white,

                                    ),),),


                                )
                              ],



                            ),
                          )],
                      ),

                    )

                  ],
                ) ),
            Text('Common Feature',style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black),),
            SizedBox(height: 32,),
    Padding(
    padding: const EdgeInsets.all(8),
    child: SingleChildScrollView(
    scrollDirection: Axis.horizontal, // Enables horizontal scrolling
    child: Row(
    children: [
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/fatwa.svg',
    text: 'Fatwa',
    onPressed: () {
    print('Fatwa Button Pressed!');
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/community.svg',
    text: 'Community',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => PostMainScreen()));
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/tasbih.svg',
    text: 'Tasbih',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => TisbahScreen()));
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/prayer_time.svg',
    text: 'Prayers',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => PrayerScreen()));
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/duas.svg',
    text: 'Dua',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => DuasScreen()));
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/quran.svg',
    text: 'Quran',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => QuranMainScreen()));
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/kiblat1.svg',
    text: 'Qiblah',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => Qiblah()));
    },
    ),
    ],
    ),
    ),
    ),

    SizedBox(height: 25,)
          ],
        ),
      ),


    );
  }
}
