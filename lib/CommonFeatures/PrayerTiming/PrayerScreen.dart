import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../Customs/CustomColor.dart';


class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  Location location = Location();
  LocationData? _currentPosition;
  double? latitude, longitude;

  @override
  void initState() {
    super.initState();
    getLoc(); // Call getLoc() in initState to initialize location
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Prayer Times',
            style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: TColors.primary,
        ),
        body: FutureBuilder(
          future: getLoc(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: TColors.primary),
              );
            }

            // Check if latitude and longitude have been initialized
            if (latitude == null || longitude == null) {
              return const Center(child: Text('Unable to get location.')); // Handle null location
            }

            final myCoordinates = Coordinates(latitude!, longitude!);
            final params = CalculationMethod.karachi.getParameters();
            params.madhab = Madhab.hanafi;
            final prayerTimes = PrayerTimes.today(myCoordinates, params);

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Fajr",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(DateFormat.jm().format(prayerTimes.fajr),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                      ],
                    ),),
                  const Divider(color: Colors.black,thickness: 1,),
                  Padding(padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sunrise",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(DateFormat.jm().format(prayerTimes.sunrise),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                      ],
                    ),),
                  const Divider(color: Colors.black,thickness: 1,),
                  Padding(padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Dhuhr",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(DateFormat.jm().format(prayerTimes.dhuhr),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                      ],
                    ),),
                  const Divider(color: Colors.black,thickness: 1,),
                  Padding(padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Asr",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(DateFormat.jm().format(prayerTimes.asr),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                      ],
                    ),),
                  const Divider(color: Colors.black,thickness: 1,),
                  Padding(padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Magrib",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(DateFormat.jm().format(prayerTimes.maghrib),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                      ],
                    ),),
                  const Divider(color: Colors.black,thickness: 1,),
                  Padding(padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Isha",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(DateFormat.jm().format(prayerTimes.isha),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                      ],
                    ),),

                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildPrayerTimeRow(String title, DateTime time) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat.jm().format(time),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getLoc() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return; // Return if service is not enabled
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return; // Return if permission is not granted
      }
    }

    _currentPosition = await location.getLocation();
    latitude = _currentPosition!.latitude; // Assign values to class variables
    longitude = _currentPosition!.longitude;

    print("Latitude: $latitude, Longitude: $longitude");
  }
}
