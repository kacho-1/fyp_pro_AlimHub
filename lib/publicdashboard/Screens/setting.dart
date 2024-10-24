import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/Authentication/SignIn.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomAppbar.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomContainier.dart';
import 'package:fyp_pro/publicdashboard/Customs/customSettingsection.dart';
import 'package:fyp_pro/publicdashboard/Profile/profilescreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Customs/CustomSettingboarding.dart';
import '../Profile/Controller/Profilecontroller.dart';

class SettingScreen extends StatefulWidget {
   SettingScreen({super.key});


  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved preferences (login state and role)
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase

    // Navigate to the Signin screen after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Signin()),
          (Route<dynamic> route) => false,  // Remove all routes from the stack
    );
  }
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child:Column(
                children: [

                  CAppBar(

                    title: Text('Account',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),),

                  ),
                  SizedBox(height: 32,),
                  ListTile(
                    leading: ClipOval(
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
                    title: Text(controller.name.value,
                    style: Theme.of(context).textTheme.headlineSmall!.apply(color:Colors.white),),
                    subtitle:Text(controller.email.value,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color:Colors.grey.shade300),),
                    trailing :IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                    }, icon: Icon(Icons.edit,color: Colors.white,)),
                  )
                ],
              )
            ),
            Padding(padding: EdgeInsets.all(24),
            child: Column(
              children: [
                TSectionsetting(title: 'Account Setting',showActionButton: false,),
                SizedBox(height: 16,),
                TSettingBody(
                  icon: Iconsax.safe_home,
                  title: 'My Address',
                  subtitle: 'Set the address',
                  traling: null,
                  onTap: (){},
                ),
                TSettingBody(
                  icon: Icons.add,
                  title: 'My Appointment',
                  subtitle: 'Alim apointments',
                  traling: null,
                  onTap: (){},
                ),

                TSettingBody(
                  icon: Iconsax.bank,
                  title: 'Bank Account',
                  subtitle: 'Add Account Details',
                  traling: null,
                  onTap: (){},
                ),
                TSettingBody(
                  icon: Icons.notifications_none,
                  title: 'Notification',
                  subtitle: 'Set any type of Notification',
                  traling: null,
                  onTap: (){},
                ),
                TSettingBody(
                  icon: Icons.security_outlined,
                  title: 'Account Privacy',
                  subtitle: 'Managed Data usage and connected accounts ',
                  traling: null,
                  onTap: (){},
                ),
                SizedBox(height: 16,),
                TSettingBody(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  subtitle: 'Set the location',
                  traling: null,
                  onTap: (){},
                ),
                SizedBox(height:
                  16,),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () async{
                    await _logout(context);

                  }, child: Text('logout',style: TextStyle(
                    color: Colors.black
                  ),)
                  ),
                )
                ,
                const SizedBox(height: 16*2.5),

              ],
            ),)


          ],
        ),
      ),
    );
  }
}
