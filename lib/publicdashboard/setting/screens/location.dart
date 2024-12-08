import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';


class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}
final controller = Get.put(ProfileController());
class _LocationScreenState extends State<LocationScreen> {
  String _country = '';
  String _city = '';
  String _area = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Function to get the current location of the user
  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = "Location services are disabled. Please enable them in settings.";
        });
        return;
      }

      // Check if the app has permission to access the user's location
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = "Location permission denied. Please allow location access in settings.";
          });
          return;
        }
      }

      // Fetch the current position (latitude, longitude)
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // Use the geocoding package to convert coordinates into a readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      // Extract country, city, and area
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _country = place.country ?? 'Unknown';
          _city = place.locality ?? 'Unknown';
          _area = place.subLocality ?? 'Unknown';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to get location: $e";
      });
    }
  }

  // Function to save the location data to Firestore
  Future<void> _saveLocation() async {
    try {
      // Assuming the user is logged in, use their UID to associate the data
      String userId = controller.userId;
      String name = controller.name.value;
      String email = controller.email.value;

      // Create a unique collection name based on the location (country, city, area)
      String locationCollectionName = 'location_${_country}_$_city$_area';

      // Save the data in the new collection named after the location
      await FirebaseFirestore.instance
          .collection(locationCollectionName)
          .doc(userId)
          .set({
        'userId': userId,
        'name': name,
        'email': email,
        'country': _country,
        'city': _city,
        'area': _area,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(_errorMessage, style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
            if (_country.isNotEmpty && _city.isNotEmpty && _area.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Country: $_country", style: TextStyle(fontSize: 18)),
                  Text("City: $_city", style: TextStyle(fontSize: 18)),
                  Text("Area: $_area", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveLocation,
                    child: Text('Save Location'),
                  ),
                ],
              ),
            if (_country.isEmpty || _city.isEmpty || _area.isEmpty)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
