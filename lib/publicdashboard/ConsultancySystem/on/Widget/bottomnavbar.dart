import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/Navabarcontroller.dart';




class BTNavBar extends StatelessWidget {
   BTNavBar({super.key});
  final controller =Get.put(BTNavigationController());
  @override
  Widget build(BuildContext context) {
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
                  icon: Icon(Icons.calendar_month_rounded), label: 'Schedules'),
            ]),
      ),
      body: Obx(
              ()=>controller.screens[controller.selectedIndex.value]),
    );
  }

}





