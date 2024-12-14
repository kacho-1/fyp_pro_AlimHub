import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../CommonFeatures/Customs/CustomColor.dart';
import '../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

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
      String locationCollectionName = 'location';

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
        const SnackBar(content: Text('Location saved successfully!')),
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
        title: const Center(child: Text('Select Location',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.start, // Center horizontally
          children: <Widget>[
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
            if (_country.isNotEmpty && _city.isNotEmpty && _area.isNotEmpty)
              Column(
                children: [
                  TextField(
                    controller: TextEditingController(text: _country),
                    decoration: const InputDecoration(labelText: "Country", border: OutlineInputBorder()),
                    readOnly: true, // Make it non-editable
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: TextEditingController(text: _city),
                    decoration: const InputDecoration(labelText: "City", border: OutlineInputBorder()),
                    readOnly: true, // Make it non-editable
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: TextEditingController(text: _area),
                    decoration: const InputDecoration(labelText: "Area", border: OutlineInputBorder()),
                    readOnly: true, // Make it non-editable
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveLocation,
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: TColors.primary,
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                      'Save Location',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            if (_country.isEmpty || _city.isEmpty || _area.isEmpty)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
