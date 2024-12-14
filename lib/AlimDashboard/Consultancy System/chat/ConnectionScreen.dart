/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CommonFeatures/Customs/CustomColor.dart';
import '../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';
import 'conversationScreen.dart';

class ConnectionScreen extends StatefulWidget {

  final String appointment;
  const ConnectionScreen({
    required this.appointment,
    super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Go to Chat Screen',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
          ),
          backgroundColor: TColors.primary,
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Start Text-Based Conversation'),
              IconButton(
                  onPressed: ConnectUser,
                  icon: const Icon(Icons.maps_ugc_sharp))
            ],
          ),
        )
    );
  }

  Future <void> ConnectUser () async{
    await ZIMKit().connectUser(
      id:controller.userId,
      name:controller.name.value,
      avatarUrl:controller.imageUrl.value,
    );
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context)=>AlimConversationMain(appoinmetId:widget.appointment,)));
  }
}
*/
