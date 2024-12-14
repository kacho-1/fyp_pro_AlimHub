import 'package:flutter/material.dart';
import 'package:fyp_pro/AlimDashboard/Consultancy%20System/chat/ConnectionScreen.dart';
import 'package:get/get.dart';
import 'package:fyp_pro/CommonFeatures/Customs/CustomColor.dart';
import 'package:intl/intl.dart';
import '../Controller/alimappointmentcontroller.dart';
import '../Widget/alimsheduler.dart';

class AlimAppointmentPage extends StatefulWidget {
  const AlimAppointmentPage({super.key});

  @override
  State<AlimAppointmentPage> createState() => _AlimAppointmentPageState();
}

enum FilterStatus { upcoming, completed }

class _AlimAppointmentPageState extends State<AlimAppointmentPage> {
  final AlimAppointmentController _controller = Get.put(AlimAppointmentController());
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;

  @override
  void initState() {
    super.initState();
    // Fetch data for the current user
    _controller.fetchAppointments();
  }
  // Check if the current time is within the consultancy's time range
  bool isWithinTimeRange(String date, String timeSlot) {
    final now = DateTime.now();
    final timeParts = timeSlot.split('-'); // e.g., "13:00-13:30"

    if (timeParts.length == 2) {
      try {
        final startTimeString = timeParts[0].trim();
        final endTimeString = timeParts[1].trim();

        // Ensure that the time strings are in "HH:mm" format
        final startTime = DateFormat("HH:mm").parse(startTimeString);
        final endTime = DateFormat("HH:mm").parse(endTimeString);

        // Parse the date from the Firebase data
        final appointmentDate = DateFormat("yyyy-MM-dd").parse(date);

        // Combine the date with the start and end time
        final startDateTime = DateTime(
          appointmentDate.year,
          appointmentDate.month,
          appointmentDate.day,
          startTime.hour,
          startTime.minute,
        );
        final endDateTime = DateTime(
          appointmentDate.year,
          appointmentDate.month,
          appointmentDate.day,
          endTime.hour,
          endTime.minute,
        );

        // Log for debugging
        print("Current Time: $now");
        print("Appointment Start: $startDateTime");
        print("Appointment End: $endDateTime");

        // Compare the current time with the appointment's start and end time
        return now.isAfter(startDateTime) && now.isBefore(endDateTime);
      } catch (e) {
        print("Error parsing time: $e");
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Appointment Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: FilterStatus.values.map((filterStatus) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              status = filterStatus;
                              _alignment = filterStatus == FilterStatus.upcoming
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight;
                            });
                          },
                          child: Center(
                            child: Text(filterStatus.name),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final appointments = status == FilterStatus.upcoming
                    ? _controller.upcomingAppointments
                    : _controller.completedAppointments;

                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    final isWithinTime = isWithinTimeRange(appointment['date'], appointment['timeSlot']);


                    return Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    appointment['profilePicture'],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointment['name'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      appointment['type'],
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            AlimScheduleCard(
                              date: appointment['date'],
                              timeSlot: appointment['timeSlot'],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (appointment['type'] == 'Text-Based')
                                  IconButton(
                                    icon: Icon(
                                      Icons.chat,
                                      color: isWithinTime ? Colors.blue : Colors.grey,
                                    ),
                                    onPressed: isWithinTime
                                        ? () {
                                      /* Navigator.push(context,MaterialPageRoute(
                                           builder:(context)=>ConnectionScreen(appointment: appointment['userId'],) ));*/
                                    }
                                        : null,
                                  ),
                                if (appointment['type'] == 'Video-call')
                                  IconButton(
                                    icon: Icon(
                                      Icons.videocam,
                                      color: isWithinTime ? Colors.green : Colors.grey,
                                    ),
                                    onPressed: isWithinTime
                                        ? () {
                                      // Handle video call consultancy

                                    }
                                        : null,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),


    );
  }
}
