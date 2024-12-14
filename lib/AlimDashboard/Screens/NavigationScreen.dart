import 'package:flutter/material.dart';
import 'package:fyp_pro/AlimDashboard/Screens/homescreen.dart';
import 'package:get/get.dart';
import '../../publicdashboard/Screens/setting.dart';

class AlimBTNavbarMain extends StatefulWidget {
  const AlimBTNavbarMain({super.key});

  @override
  State<AlimBTNavbarMain> createState() => _AlimBTNavbarMainState();
}

class _AlimBTNavbarMainState extends State<AlimBTNavbarMain> {
  @override
  Widget build(BuildContext context) {
    final controller =Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
            () =>  NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex:controller.selectedIndex.value,
            onDestinationSelected: (index)=> controller.selectedIndex.value = index,
            //),
            destinations: const
            [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            ]),
      ),
      body: Obx(
              ()=>controller.screens[controller.selectedIndex.value]),
    );
  }

}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [const AlimHomeScreen(),const SettingScreen()];
}

