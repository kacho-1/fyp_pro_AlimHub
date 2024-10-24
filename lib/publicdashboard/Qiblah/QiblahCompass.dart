import 'dart:async';
import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:fyp_pro/publicdashboard/Qiblah/LocationErrorWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'LocationErrorWidget.dart';  // Your custom widget for errors

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final locationStreamController = StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => locationStreamController.stream;

  Future<void> _checkLocationStatus() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, add an error to the stream
      locationStreamController.sink.add(LocationStatus(false, LocationPermission.denied));
      return;
    }

    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        // Permissions are denied, return error
        locationStreamController.sink.add(LocationStatus(true, permission));
        return;
      }
    }

    // Location services are enabled and permissions granted, proceed
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    locationStreamController.sink.add(locationStatus);
  }

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();  // Check location services and permissions
  }

  @override
  void dispose() {
    locationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationStatus>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.data!.enabled) {
          return LocationErrorWidget(
            error: 'Location services are disabled. Please enable them.',
            callback: () async {
              await Geolocator.openLocationSettings();
              _checkLocationStatus();  // Recheck status after user interaction
            },
          );
        }

        if (snapshot.data!.status == LocationPermission.deniedForever) {
          return LocationErrorWidget(
            error: 'Location permission is permanently denied. Open app settings.',
            callback: () async {
              await Geolocator.openAppSettings();
              _checkLocationStatus();  // Recheck status after user interaction
            },
          );
        }

        if (snapshot.data!.status == LocationPermission.denied) {
          return LocationErrorWidget(
            error: 'Location permission is denied. Please allow access.',
            callback: _checkLocationStatus,  // Retry the check after user grants permissions
          );
        }

        // Show the Qiblah compass if everything is OK
        return QiblahCompassWidget();  // Replace this with your actual compass widget
      },
    );
  }
}

class QiblahCompassWidget extends StatelessWidget {
  QiblahCompassWidget({super.key});
  final compass = SvgPicture.asset('assets/images/Qiblah/kiblat_lingkar.svg');
  final needle = SvgPicture.asset('assets/images/Qiblah/kiblat_needle.svg',
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (_,AsyncSnapshot<QiblahDirection>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final qiblahDirection = snapshot.data!;

          return Stack(
            alignment:  Alignment.center,
            children: <Widget>[
              Transform.rotate(angle: (qiblahDirection.direction*(pi/180)*-1),
                child: compass,
              ),
              Transform.rotate(angle: (qiblahDirection.qiblah*(pi/180)*-1),
                alignment: Alignment.center,
                child: needle,),
              Positioned(
                  bottom:8,
                  child:Text('${qiblahDirection.offset.toStringAsFixed(3)} °') )

            ],
          );
        }
    );
  }
}


