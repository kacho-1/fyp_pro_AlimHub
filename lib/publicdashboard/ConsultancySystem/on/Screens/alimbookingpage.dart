import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Screens/paymnetmethod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../CommonFeatures/Customs/CustomColor.dart';
import '../../../../CommonFeatures/Profile/Controller/Profilecontroller.dart';

class AlimBookingPage extends StatefulWidget {
  final String alimData; // Pass Alim UID
  final String ConsultancyType;
  const AlimBookingPage({required this.alimData,required this.ConsultancyType, super.key});

  @override
  State<AlimBookingPage> createState() => _AlimBookingPageState();
}

class _AlimBookingPageState extends State<AlimBookingPage> {
  final controller = Get.put(ProfileController());
  DateTime? _selectedDate;
  int? _selectedTimeIndex;
  bool _dateSelected = false;
  bool _timeSelected = false;
  List<Map<String, dynamic>> _timeSlots = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Booking'),
      ),
      body: Column(
        children: [
          // Date Picker using Syncfusion Calendar
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              todayHighlightColor: TColors.primary,
              selectionDecoration: BoxDecoration(
                border: Border.all(color: TColors.primary, width: 2),
              ),
              onSelectionChanged: (details) {
                DateTime selectedDate = details.date!;
                if (selectedDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Cannot select past dates.")),
                  );
                } else {
                  setState(() {
                    _selectedDate = selectedDate;
                    _dateSelected = true;
                    _fetchTimeSlotsForDate(); // Fetch time slots for the selected date
                  });
                }
              },

            ),
          ),
          // Display Time Slots
          Expanded(
            child: _dateSelected
                ? _timeSlots.isEmpty
                ? const Center(child: Text("No slots available for this date."))
                : ListView.builder(
              itemCount: _timeSlots.length,
              itemBuilder: (context, index) {
                bool isBooked = _timeSlots[index]['isBooked'];
                return ListTile(
                  title: Text(
                    "${_timeSlots[index]['startTime']} - ${_timeSlots[index]['endTime']}",
                    style: TextStyle(
                      color: isBooked ? Colors.red : Colors.black,
                      decoration: isBooked ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: isBooked
                      ? const Text("Booked")
                      : Radio<int>(
                    value: index,
                    groupValue: _selectedTimeIndex,
                    onChanged: (value) {
                      setState(() {
                        _selectedTimeIndex = value;
                        _timeSelected = true;
                      });
                    },
                  ),
                );
              },
            )
                : const Center(child: Text("Select a date to view time slots.")),
          ),
          // Confirm Button
          ElevatedButton(
            onPressed: _dateSelected && _timeSelected ? _saveAppointment : null,
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: TColors.primary,
              minimumSize: const Size (200,50),

            ),
            child: const Text("Proceed to Payment",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white
            )),
          ),
        ],
      ),
    );
  }

  // Fetch available time slots for the selected date
  Future<void> _fetchTimeSlotsForDate() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('alim_availability')
          .doc(widget.alimData)
          .collection('timeSlots')
          .doc(formattedDate)
          .get();

      if (snapshot.exists) {
        List<Map<String, dynamic>> slots = List<Map<String, dynamic>>.from(snapshot['slots']);

        // Ensure all slots have the isBooked field
        slots = slots.map((slot) {
          return {
            "startTime": slot["startTime"],
            "endTime": slot["endTime"],
            "isBooked": slot["isBooked"] ?? false, // Default to false if null
          };
        }).toList();

        setState(() {
          _timeSlots = slots;
        });
      } else {
        setState(() {
          _timeSlots = [];
        });
      }
    } catch (e) {
      print("Error fetching time slots: $e");
    }
  }


  // Save appointment to Firestore
  // Save appointment to Firestore
  Future<void> _saveAppointment() async {
    try {
      String name = controller.name.value;
      String imgUrl = controller.imageUrl.toString();
      String userId = controller.userId; // Replace with the actual logged-in user's ID
      String alimId = widget.alimData;
      String consultancytype = widget.ConsultancyType;
      String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      Map<String, dynamic> selectedSlot = _timeSlots[_selectedTimeIndex!];

      // Generate unique room ID
      String roomId = "${alimId.substring(0, 4)}_${userId.substring(0, 4)}";

      // Determine if it's a chat or video room
      String roomKey = consultancytype == "Text-based" ? "chatRoomId" : "videoRoomId";
      String appointmentId = _firestore.collection('appointments').doc().id;
      // Create the appointment
      DocumentReference appointmentRef = _firestore.collection('appointments').doc();

      await appointmentRef.set({
        "appointmentId": appointmentId,
        "userId": userId,
        "alimId": alimId,
        "date": formattedDate,
        "timeSlot": "${selectedSlot['startTime']} - ${selectedSlot['endTime']}",
        "type": consultancytype, // Consultancy type selected by the user
        "status": "upcoming",
        "name": name,
        "profilePicture": imgUrl,
        "startTime": selectedSlot['startTime'],
        "endTime": selectedSlot['endTime'],
        roomKey: roomId, // Save chatRoomId or videoRoomId
      });

      // Update the time slot as booked
      _timeSlots[_selectedTimeIndex!]['isBooked'] = true;
      await _firestore
          .collection('alim_availability')
          .doc(alimId)
          .collection('timeSlots')
          .doc(formattedDate)
          .update({"slots": _timeSlots});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Appointment booked successfully.")),
      );

      // Navigate to payment
      Get.to(() => const PaymentMethodPage()); // Replace with your payment screen
    } catch (e) {
      print("Error saving appointment: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to book appointment.")),
      );
    }
  }

}
