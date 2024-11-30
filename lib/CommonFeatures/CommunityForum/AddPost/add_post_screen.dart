import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Profile/Controller/Profilecontroller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import '../../../CommonFeatures/Customs/CustomColor.dart';
import 'Controller/add_post_controller.dart';


class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);

  final _profileController = Get.put(ProfileController());
  final _postController = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
            child: Column(
              children: [
                Obx(() {
                  return _profileController.imageUrl.value.isNotEmpty
                      ? Row(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          imageUrl: _profileController.imageUrl.value,
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/account.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(

                        child: Text(
                          _profileController.name.value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: Colors.black),
                          maxLines: 2, // Limit the number of lines
                          overflow: TextOverflow.ellipsis,),
                      ),
                    ],
                  )
                      : Container();
                }),
                const SizedBox(
                  height: 14,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 14,
                ),
                TextField(
                  controller: _postController.postTxtController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Write here...",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                GestureDetector(
                  onTap: () {
                    _postController.getImage();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                    child: Obx(() {
                      return _postController.selectedImagePath.value == ''
                          ? const Icon(
                        Icons.image,
                        size: 45,
                      )
                          : Image.file(
                        File(_postController.selectedImagePath.value),
                        fit: BoxFit.fill,
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: TColors.primary, // Text color
                      ),
                      onPressed: () {
                      if (_postController.postTxtController.text.trim().isEmpty) {
    // You can show an alert if the text is empty
                        showDialog(
                         context: context,
                          builder: (ctx) => AlertDialog(
                           title: Text('Empty Post'),
                            content: Text('Please enter some text or select an image.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                 Navigator.of(ctx).pop();
                               },
                                child: Text('OK'),
                               ),
                                ],
                                ),
                                );
                               return;

                      };_postController.addPost(
                        userName: _profileController.name.value,
                        userUrl: _profileController.imageUrl.value,
                      );
                      },

                      child: _postController.isLoading.value
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Post',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: Colors.white),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
