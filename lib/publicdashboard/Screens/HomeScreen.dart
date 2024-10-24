import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomAppPortion.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomAppbar.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomContainier.dart';
import 'package:fyp_pro/publicdashboard/Profile/Controller/Profilecontroller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:fyp_pro/publicdashboard/PrayerTiming/UpcomingPrayerTime.dart';
import 'package:location/location.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart';

import '../CommunityForum/Main/Controller/main_screen_controller.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
Location location = Location();
String upcomingPrayer = 'Loading...';

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    getUpcomingPrayer();
  }
  Future<void> getUpcomingPrayer() async {
    String prayer = await PrayerUtils.getUpcomingPrayer(location);
    setState(() {
      upcomingPrayer = prayer;
    });
  }
  final _controller = Get.put(MainScreenController(),permanent: true);
  final controller = Get.put(ProfileController());
  Widget build(BuildContext context) {
    var hijra = HijriCalendar.now();


    return Scaffold(

      body: SingleChildScrollView(
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
                            Text(controller.name.value,style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.grey.shade300,fontFamily: 'Poppins-Medium',)),


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

                                  )),),


                                )
                              ],



                          ),
                          )],
                      ),

                    )

                  ],
                ) ),
            Text('Category',style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black),),
            SizedBox(height: 32,),
            CAppPortion(),
            SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
