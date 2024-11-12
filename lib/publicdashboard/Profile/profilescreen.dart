import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomProfile.dart';
import 'package:fyp_pro/publicdashboard/Customs/customSettingsection.dart';
import 'package:fyp_pro/publicdashboard/Profile/Controller/Profilecontroller.dart';
import 'package:fyp_pro/publicdashboard/Profile/Screens/Updatename.dart';
import 'package:fyp_pro/publicdashboard/Profile/Screens/updatedob.dart';
import 'package:fyp_pro/publicdashboard/Profile/Screens/updategender.dart';
import 'package:fyp_pro/publicdashboard/Profile/Screens/updatenumber.dart';
import 'package:fyp_pro/publicdashboard/Profile/Screens/updateprofilepicture.dart';
import 'package:fyp_pro/publicdashboard/Profile/Screens/updateusername.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import 'deleteaccount/deleteaccountPopup.dart';


class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Profile',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
        backgroundColor: TColors.primary,
      ),

      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Obx(()=>Column(
                  children: [
                  Center(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        height: 80-12*2,
                        width: 80-12*2,
                        fit: BoxFit.cover,
                        imageUrl: controller.imageUrl.value,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/my.png'),
                      ),
                    ),

                  ),
                    TextButton(onPressed: (){
                     Get.to(()=>ChangeProfilePictureScreen());
                    },
                        child: Text('Change Profile Picture')),

                    ],
                ),
                ),
              ),
              SizedBox(height: 8,),
              Divider(),
              SizedBox(height: 16,),
              TSectionsetting(title: 'Profile Information', showActionButton: false,),
              SizedBox(height: 16,),
              Obx(()=>TProfileMenu(onPressed: ()=> Get.to(() =>  ChangeName()), title: 'Name', value: controller.name.value),),
              Obx(()=>TProfileMenu(onPressed: ()=> Get.to(() =>  ChangeUserName()), title: 'UserName', value: controller.username.value)),
              SizedBox(height: 16,),
              Divider(),
              SizedBox(height: 16,),
              
              TSectionsetting(title: 'Personal Information', showActionButton: false,),
              SizedBox(height: 16,),
              TProfileMenu(onPressed: ()=>copyToClipboard(controller.userId), title: 'UserId', value: controller.userId,icon: Iconsax.copy,),
              TProfileMenu(onPressed: ()=>copyToClipboard(controller.email.value), title: 'Email', value: controller.email.value,icon: Iconsax.copy),
              Obx(()=>TProfileMenu(onPressed: ()=> Get.to(()=>ChangePhoneNumber()), title: 'Phone', value: controller.phone.value)),
              Obx(()=> TProfileMenu(onPressed: ()=> Get.to(()=>ChangeGender()), title: 'Gender', value: controller.gender.value)),
              Obx(()=>TProfileMenu(onPressed: ()=> Get.to(()=>ChangeDateOfBirth()), title: 'Date of Birth', value: controller.dob.value)),
            Divider(),
            SizedBox(height: 16,),
            
            Center(
              child: TextButton(
                  onPressed: (){
                    deleteAccountWarningPop();
                  },
                  child:Text('Close Account',
                  style: TextStyle(color: Colors.red),)),
            )  

            ],
          ),
        ),
      ),
    );
  }
}
void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text)).then((_) {
    Get.snackbar(
      'Success',
      'Text copied to clipboard',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  });
}