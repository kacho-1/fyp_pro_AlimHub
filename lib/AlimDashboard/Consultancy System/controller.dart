import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlimAvailabilityController extends GetxController {
  var selectedDates = <DateTime>[].obs; // Observable list of selected dates
  var timeSlots = <DateTime, List<Map<String, dynamic>>>{}.obs; // Map of time slots by date

  late final String alimId; // Alim's UID
  var dateFieldText = ''.obs; // Observable for the text field value

  @override
  void onInit() {
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      alimId = user.uid; // Set the Alim ID to the current user's UID
    } else {
      Get.snackbar('Error', 'No authenticated user found.');
    }
  }

  // Method to add a selected date
  void addSelectedDate(DateTime date) {
    if (!selectedDates.contains(date)) {
      selectedDates.add(date);
      fetchTimeSlots(date); // Fetch existing time slots for the selected date

      // Update the dateFieldText with the selected date and day
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      String dayName = DateFormat('EEEE').format(date);
      dateFieldText.value = '$formattedDate ($dayName)';
    }
  }

  // Method to remove a selected date
  void removeSelectedDate(DateTime date) {
    selectedDates.remove(date);
    timeSlots.remove(date); // Remove time slots for that date
  }

  // Fetch time slots from Firestore for a specific date
  Future<void> fetchTimeSlots(DateTime date) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      var snapshot = await FirebaseFirestore.instance
          .collection('alim_availability')
          .doc(alimId)
          .collection('timeSlots')
          .doc(formattedDate)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        List<Map<String, dynamic>> slots = List<Map<String, dynamic>>.from(snapshot['slots'] ?? []);
        timeSlots[date] = slots;
      } else {
        timeSlots[date] = []; // No slots available for the selected date
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch time slots: $e');
    }
  }

  // Method to add a new slot for a specific date
  Future<void> addSlot(DateTime date, String startTime, String endTime) async {
    try {
      // Format the date for querying
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      // Reference to the Firestore document
      DocumentReference dateDocRef = FirebaseFirestore.instance
          .collection('alim_availability')
          .doc(alimId) // assuming alimId is available
          .collection('timeSlots')
          .doc(formattedDate);

      // Fetch the existing document
      DocumentSnapshot snapshot = await dateDocRef.get();
      if (snapshot.exists) {
        // Cast data to Map<String, dynamic>
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> slots = data['slots'] ?? [];

        // Debugging: Log current slots
        print('Current Slots: $slots');

        // Check if a slot with the same startTime already exists
        bool slotExists = slots.any((slot) {
          print('Comparing with slot startTime: ${slot['startTime']}');
          return slot['startTime'] == startTime;  // Compare the start time
        });

        if (slotExists) {
          // If slot already exists, show an error message
          Get.snackbar('Error', 'This time slot already exists for this date.');
          return; // Prevent adding the duplicate slot
        }

        // If no duplicate found, add the new slot
        slots.add({
          'startTime': startTime,
          'endTime': endTime,
          'isBooked':false,
        });

        // Update Firestore with the new slot
        await dateDocRef.update({'slots': slots});
        Get.snackbar('Success', 'Slot added successfully!');
      } else {
        // If no document exists for the given date, create a new one
        await dateDocRef.set({
          'slots': [{
            'startTime': startTime,
            'endTime': endTime,
          }],
        });
        Get.snackbar('Success', 'Slot added successfully!');
      }

      fetchTimeSlots(date); // Refresh the time slots list
    } catch (e) {
      Get.snackbar('Error', 'Failed to add slot: $e');
    }
  }


  // Method to delete a slot for a specific date
  Future<void> deleteSlot(DateTime date, String startTime) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      DocumentReference dateDocRef = FirebaseFirestore.instance
          .collection('alim_availability')
          .doc(alimId)
          .collection('timeSlots')
          .doc(formattedDate);

      // Fetch the existing document
      DocumentSnapshot snapshot = await dateDocRef.get();
      if (snapshot.exists) {
        // Cast data to Map<String, dynamic> to safely access it
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> slots = data['slots'] ?? [];

        // Find and remove the slot with the specified start time
        slots.removeWhere((slot) => slot['startTime'] == startTime);

        // Update the slots array in Firestore
        await dateDocRef.update({'slots': slots});

        fetchTimeSlots(date); // Refresh the time slots list after deleting the slot
        Get.snackbar('Success', 'Slot deleted successfully!');
      } else {
        Get.snackbar('Error', 'No slots found for this date.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete slot: $e');
    }
  }

  Future<void> editSlot(DateTime date, String oldStartTime, String newStartTime, String newEndTime) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      DocumentReference dateDocRef = FirebaseFirestore.instance
          .collection('alim_availability')
          .doc(alimId)
          .collection('timeSlots')
          .doc(formattedDate);

      // Fetch the existing document
      DocumentSnapshot snapshot = await dateDocRef.get();
      if (snapshot.exists) {
        // Cast data to Map<String, dynamic> to safely access it
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> slots = data['slots'] ?? [];

        // Find and update the slot with the old start time
        for (int i = 0; i < slots.length; i++) {
          if (slots[i]['startTime'] == oldStartTime) {
            slots[i] = {'startTime': newStartTime, 'endTime': newEndTime};
            break;
          }
        }

        // Update the slots array in Firestore
        await dateDocRef.update({'slots': slots});

        fetchTimeSlots(date); // Refresh the time slots list after editing the slot
        Get.snackbar('Success', 'Slot updated successfully!');
      } else {
        Get.snackbar('Error', 'No slots found for this date.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to edit slot: $e');
    }
  }


  // Method to update a slot for a specific date
  void updateSlot(DateTime date, String timeSlotId, String startTime, String endTime, int slotIndex) {
    // Get the reference to the document where the slot data is stored
    final slotRef = FirebaseFirestore.instance.collection('timeSlots').doc(date.toIso8601String());

    // Update the specific slot at the given index
    slotRef.update({
      'slots': FieldValue.arrayRemove([timeSlotId]),  // Remove the old slot by its ID
    });

    // Create the updated slot with the new times
    final updatedSlot = {
      'id': timeSlotId,
      'startTime': startTime,
      'endTime': endTime,
    };

    // Add the updated slot back to the 'slots' field
    slotRef.update({
      'slots': FieldValue.arrayUnion([updatedSlot]),  // Add the updated slot back to the array
    });
  }

}
