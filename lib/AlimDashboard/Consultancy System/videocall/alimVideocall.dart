/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';
import '../../../publicdashboard/utility/utilitys.dart';
class AlimVideoCallPage extends StatefulWidget {
  final String callID;

  AlimVideoCallPage({
    Key? key,
    required this.callID,
  }) : super(key: key);

  @override
  State<AlimVideoCallPage> createState() => _AlimVideoCallPageState();
}

class _AlimVideoCallPageState extends State<AlimVideoCallPage> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID:VideoappId ,
        appSign: VideoSignId,
        userID: controller.userId,
        userName: controller.name.value,
        callID: widget.callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) {
            Navigator.of(context).pop();
          },
      ),
    );
  }
}*/
