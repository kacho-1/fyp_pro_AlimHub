import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:location/location.dart';
import '../../CommonFeatures/CommunityForum/Main/Controller/main_screen_controller.dart';
import '../../CommonFeatures/Customs/CustomAppPortion.dart';
import '../../CommonFeatures/Customs/CustomAppbar.dart';
import '../../CommonFeatures/Customs/CustomColor.dart';
import '../../CommonFeatures/Customs/CustomContainier.dart';
import '../../CommonFeatures/PrayerTiming/UpcomingPrayerTime.dart';
import '../../CommonFeatures/Profile/Controller/Profilecontroller.dart';


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
                            Obx(()=>Text(controller.name.value,style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.grey.shade300,fontFamily: 'Poppins-Medium',))),


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
                                    child: Text('\n${hijra.hYear} AH', style:Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white,

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
