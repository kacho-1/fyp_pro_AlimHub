import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:fyp_pro/CommonFeatures/Qiblah/QiblahCompass.dart';

import '../Customs/CustomColor.dart';

class Qiblah extends StatefulWidget {
  final devicesupport = FlutterQiblah.androidDeviceSensorSupport();
   Qiblah({super.key});

  @override
  State<Qiblah> createState() => _QiblahState();
}

class _QiblahState extends State<Qiblah> {
  final qiblahSupport = FlutterQiblah.androidDeviceSensorSupport();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Qiblah Direction',
            style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: TColors.primary,
        ),
        body: FutureBuilder(
            future: qiblahSupport,
            builder:(_,AsyncSnapshot<bool?>snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.hasError)
              {
                return Center(
                  child: Text('Error ${snapshot.error.toString()}'),
                );
              }
              if (snapshot.data!){
                return const QiblahCompass();
              }
              else{
                return const Center(
                  child: Text('Your Device is not Supported'),
                );
              }

            }


        ),
      ),
    );
  }
}
