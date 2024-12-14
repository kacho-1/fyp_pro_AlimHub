import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Customs/CustomColor.dart';
import 'Controller/main_screen_controller.dart';

class PostMainScreen extends StatelessWidget {
  PostMainScreen({super.key});

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
