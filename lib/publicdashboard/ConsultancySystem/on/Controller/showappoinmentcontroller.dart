import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';

class AppointmentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final controller = Get.put(ProfileController());
  var upcomingAppointments = <Map<String, dynamic>>[].obs;
  var completedAppointments = <Map<String, dynamic>>[].obs;

  // Fetch appointments for the current user
  Future<void> fetchAppointments() async {
    try {
       final String userId = controller.userId;
      final appointmentsSnapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .get();

      final appointments = appointmentsSnapshot.docs.map((doc) => doc.data()).toList();

      List<Map<String, dynamic>> upcoming = [];
      List<Map<String, dynamic>> completed = [];

      // Fetch Alim details for each appointment
      for (var appointment in appointments) {
        final alimId = appointment['alimId'];
        final alimSnapshot = await _firestore
            .collection('alim_availability')
            .where('alimUid', isEqualTo: alimId)
            .limit(1)
            .get();

        if (alimSnapshot.docs.isNotEmpty) {
          final alimData = alimSnapshot.docs.first.data();
          appointment['videoRoomId'] = alimData['videoRoomId'];
          appointment['alim_name'] = alimData['alimname'];
          appointment['alim_profile'] = alimData['alimimage'];
        } else {
          appointment['alim_name'] = "Unknown Alim";
          appointment['alim_profile'] = "assets/images/default_profile.png";
          appointment['videoRoomId'] = 'UnknownId';
        }

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
