

import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/CommunityForum/ShowPost/Wigets/postitem.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Customs/CustomColor.dart';
import '../../Profile/Controller/Profilecontroller.dart';
import 'Controller/Showpostcontroller.dart';

class ShowPostMain extends StatelessWidget {
   ShowPostMain({super.key});
  final _profileController = Get.put(ProfileController());
  final _showpostController = Get.put(ShowPostController());
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('AlimHub Community',
        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: TColors.primary,
        centerTitle: true,

      ),
      body: SafeArea(
       child: GetX<ShowPostController>(
        init: Get.put<ShowPostController>(ShowPostController()),
        builder: (ShowPostController showPostcontroller){
          if(showPostcontroller.posts.isNotEmpty){
            return Expanded(
                child: ListView.builder(
                    itemCount: showPostcontroller.posts.length,
                    itemBuilder:(context,index){
                      return PostItem(post: showPostcontroller.posts[index]);
                    },
                ),
            );
          }
          else {
             return Center( child: CircularProgressIndicator(),);

          }
        },
       ),
      )
    );
  }
}
