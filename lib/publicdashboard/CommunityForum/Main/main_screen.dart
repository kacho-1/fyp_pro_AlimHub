import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/Main/Controller/main_screen_controller.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';
import 'package:get/get.dart';

class PostMainScreen extends StatelessWidget {
  PostMainScreen({Key? key}) : super(key: key);

  final _controller = Get.put(MainScreenController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: _controller.widgetOptions.elementAt(_controller.selectedIndex.value),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Post',
              ),


            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: TColors.primary,
            currentIndex: _controller.selectedIndex.value,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            iconSize: 40,
            onTap: _controller.onItemTapped,
            elevation: 5
        ),
      );
    });
  }
}
