import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/AlimDashboard/Consultancy%20System/Screens/ConsultancyNavbar.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
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
        title:  const Center(
          child: Text('Welcome to Alim Dashboard',style: TextStyle(fontSize:
          16,fontWeight: FontWeight.bold,color: Colors.white),),

        ),
        backgroundColor: TColors.primary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white), // Custom drawer icon color
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
              decoration: const BoxDecoration(
                color: TColors.primary,
              ),
              child: Column(
                children: [
                  const Text(
                    'Alim Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  SingleChildScrollView(
                    child: Column(
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade300
                            ),maxLines: 1,
                          )),
                          subtitle:Text(controller.email.value,
                            style: Theme.of(context).textTheme.bodyMedium!.apply(color:Colors.grey.shade300),textAlign: TextAlign.justify,),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Fatwa'),
              onTap: () {
                // Navigate to the Scholar Upload Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Add Event'),
              onTap: () {
                // Navigate to the Create Event Screen


              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Appointments'),
              onTap: () {
                // Navigate to the Create Event Screen
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ConsultancyBTNavbar()));

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
                            Obx(()=>Text(controller.name.value,style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.grey.shade300,fontFamily: 'Poppins-Medium',))),


                          ],
                        ),
                        actions: [
                          Stack(
                              children: [
                                IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_rounded,color: Colors.white,)),
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
                    const SizedBox(height: 20),
                    Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: TColors.textWhite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white)
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search,color: TColors.primary,),
                            const SizedBox(width: 5,),
                            Text('Click her to Search',style: Theme.of(context).textTheme.bodySmall),

                          ],
                        ),

                      ),
                    ),
                    const SizedBox(height: 14,),

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
                                  child: Padding(padding: const EdgeInsets.all(4),
                                      child: Text( hijra.hDay.toString(),
                                          style:Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white,

                                          ))),


                                ),
                                WidgetSpan(
                                  child: Padding(padding: const EdgeInsets.all(4),

                                      child: Text(hijra.longMonthName,style:Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white,

                                      ))),

                                ),

                                WidgetSpan(
                                  child: Padding(padding: const EdgeInsets.all(4),
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
            const SizedBox(height: 32,),
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
    context, MaterialPageRoute(builder: (context) => const TisbahScreen()));
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/prayer_time.svg',
    text: 'Prayers',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => const PrayerScreen()));
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/duas.svg',
    text: 'Dua',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => const DuasScreen()));
    },
    ),
    SvgTextButton(
    svgPath: 'assets/images/collection_icon/quran.svg',
    text: 'Quran',
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => const QuranMainScreen()));
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

    const SizedBox(height: 25,)
          ],
        ),
      ),


    );
  }
}
