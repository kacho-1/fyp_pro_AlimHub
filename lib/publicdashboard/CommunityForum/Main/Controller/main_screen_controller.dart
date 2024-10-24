import 'package:fyp_pro/publicdashboard/CommunityForum/AddPost/add_post_screen.dart';
import 'package:fyp_pro/publicdashboard/CommunityForum/ShowPost/Showpostmain.dart';
import 'package:get/get.dart';
import 'dart:developer';

class MainScreenController extends GetxController{

  RxInt selectedIndex = 0.obs;

  final widgetOptions =  [
    ShowPostMain(),
    AddPostScreen(),
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
    //log(selectedIndex.string);
  }

}