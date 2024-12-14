import 'package:flutter/material.dart';
import 'package:fyp_pro/AlimDashboard/Consultancy%20System/Screens/Addconsultancydetails.dart';
import 'package:fyp_pro/AlimDashboard/Consultancy%20System/Screens/ConsultancyHomeScreen.dart';
import 'package:fyp_pro/AlimDashboard/Consultancy%20System/Screens/addconsultancyscreen.dart';
import 'package:get/get.dart';

class ConsultancyBTNavbar extends StatelessWidget{
  const ConsultancyBTNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(AlimConsultancyBTNavigationController());
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
                  icon: Icon(Icons.add_outlined), label: 'Add Details'),
              NavigationDestination(icon: Icon(Icons.add_box_outlined), label: 'Set Availbility'),
            ]),
      ),
      body: Obx(
              ()=>controller.screens[controller.selectedIndex.value]),
    );
  }

}

class AlimConsultancyBTNavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [const AlimAppointmentPage(),AddConsultancyDetals(), AlimAvailabilityScreen()];
}

