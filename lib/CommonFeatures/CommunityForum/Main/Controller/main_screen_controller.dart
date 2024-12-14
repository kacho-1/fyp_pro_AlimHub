import 'package:get/get.dart';
import '../../AddPost/add_post_screen.dart';
import '../../ShowPost/Showpostmain.dart';

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