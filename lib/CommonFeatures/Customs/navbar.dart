import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Screens/Catagory.dart';
import 'package:fyp_pro/publicdashboard/Screens/HomeScreen.dart';
import 'package:fyp_pro/publicdashboard/Screens/setting.dart';
import 'package:get/get.dart';


class Navigati extends StatelessWidget{
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
              NavigationDestination(
                  icon: Icon(Icons.category), label: 'Category'),
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
final screens = [HomeScreen(),CatagoryScreen(),SettingScreen()];
}

