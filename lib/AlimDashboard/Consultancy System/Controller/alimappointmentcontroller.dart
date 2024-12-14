import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';

class AlimAppointmentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final controller = Get.put(ProfileController());
  var upcomingAppointments = <Map<String, dynamic>>[].obs;
  var completedAppointments = <Map<String, dynamic>>[].obs;

  // Fetch appointments for the current Alim
  Future<void> fetchAppointments() async {
    try {
      final String alimId = controller.userId; // Assuming Alim's UID is stored here
      final appointmentsSnapshot = await _firestore
          .collection('appointments')
          .where('alimId', isEqualTo: alimId)
          .get();

      final appointments = appointmentsSnapshot.docs.map((doc) => doc.data()).toList();

      List<Map<String, dynamic>> upcoming = [];
      List<Map<String, dynamic>> completed = [];

      // Process each appointment to extract user details
      for (var appointment in appointments) {

        // Add default values if data is missing
        appointment['videoRoomId'] = appointment['videoRoomId'] ?? 'no videoRoomId';
        appointment['userId'] = appointment['userId'] ?? 'no user Id';
        appointment['name'] = appointment['name'] ?? "Unknown User";
        appointment['profilePicture'] =
            appointment['profilePicture'] ?? "assets/images/default_profile.png";

        // Separate appointments by status
        if (appointment['status'] == 'upcoming') {
          upcoming.add(appointment);
        } else if (appointment['status'] == 'completed') {
          completed.add(appointment);
        }
      }

      // Update the observable lists
      upcomingAppointments.value = upcoming;
      completedAppointments.value = completed;
    } catch (e) {
      print("Error fetching appointments: $e");
    }
  }
}
