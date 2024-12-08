import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DataFetchController extends GetxController {
  var alimList = <AlimAvailabilityModel>[].obs; // Observable list of alim availability
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch alim availability data
  Future<void> fetchAlimAvailability() async {
    try {
      // Fetching all the documents in the alim_availability collection
      QuerySnapshot alimSnapshot = await _firestore.collection('alim_availability').get();

      if (alimSnapshot.docs.isNotEmpty) {
        alimList.clear(); // Clear the list before adding new data

        // Loop through all documents (Alims)
        for (var alimDoc in alimSnapshot.docs) {
          // Fetch the time slots for each Alim
         // var timeSlotsSnapshot = await alimDoc.reference.collection('timeSlots').get();

          // Fetching the data of the alim
          AlimAvailabilityModel alim = AlimAvailabilityModel(
            alimUid: alimDoc['alimUid'],
            alimName: alimDoc['alimname'],
            alimImage: alimDoc['alimimage'],
            about: alimDoc['about'],
            experience: alimDoc['experience'],
            fee: alimDoc['fee'],
            specialty: alimDoc['specialty'],
            createdAt: alimDoc['createdAt'],
            timeSlots: await _fetchTimeSlots(alimDoc),  // Fetch the time slots for the alim
          );

          alimList.add(alim); // Add the Alim to the list
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch Alim availability data: $e');
    }
  }

  // Helper method to fetch time slots for each Alim
  Future<List<TimeSlot>> _fetchTimeSlots(DocumentSnapshot alimDoc) async {
    List<TimeSlot> timeSlots = [];

    // Fetch time slots for each date
    var timeSlotsSnapshot = await alimDoc.reference.collection('timeSlots').get();

    for (var dateDoc in timeSlotsSnapshot.docs) {
      List<Map<String, String>> slots = [];

      // Iterate through the 'slots' array in each document
      for (var slot in dateDoc['slots']) {
        slots.add({
          'startTime': slot['startTime'],
          'endTime': slot['endTime'],
        });
      }

      // Add the time slots for this date
      timeSlots.add(TimeSlot(
        date: dateDoc.id,  // The document ID is the formatted date
        slots: slots,
      ));
    }

    return timeSlots;
  }
}

// Model to represent Alim availability
class AlimAvailabilityModel {
  final String alimUid;
  final String alimName;
  final String alimImage;
  final String about;
  final String experience;
  final String fee;
  final String specialty;
  final Timestamp createdAt;
  final List<TimeSlot> timeSlots;

  AlimAvailabilityModel({
    required this.alimUid,
    required this.alimName,
    required this.alimImage,
    required this.about,
    required this.experience,
    required this.fee,
    required this.specialty,
    required this.createdAt,
    required this.timeSlots,
  });

  // Convert model to map for Firestore saving
  Map<String, dynamic> toMap() {
    return {
      'alimUid': alimUid,
      'alimname': alimName,
      'alimimage': alimImage,
      'about': about,
      'experience': experience,
      'fee': fee,
      'specialty': specialty,
      'createdAt': createdAt,
    };
  }
}

// Model to represent time slots
class TimeSlot {
  final String date;
  final List<Map<String, String>> slots;

  TimeSlot({
    required this.date,
    required this.slots,
  });
}
