import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../CommonFeatures/Customs/CustomColor.dart';
import 'paymnetmethod.dart';

class AlimBookingPage extends StatefulWidget {
  final String alimData; // Pass Alim UID
  const AlimBookingPage({required this.alimData, super.key});

  @override
  State<AlimBookingPage> createState() => _AlimBookingPageState();
}

class _AlimBookingPageState extends State<AlimBookingPage> {
  DateTime? _selectedDate;
  bool _dateSelected = false;
  bool _timeSelected = false;
  int? _selectedTimeIndex;

  List<Map<String, dynamic>> _timeSlots = []; // Dynamic time slots list
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, List<Map<String, dynamic>>> _cachedTimeSlots = {}; // Cache for fetched slots

  // Fetch time slots for the selected date
  Future<void> _fetchTimeSlotsForDate() async {
    if (_selectedDate == null) return;

    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);

    // Check cache first
    if (_cachedTimeSlots.containsKey(formattedDate)) {
      setState(() {
        _timeSlots = _cachedTimeSlots[formattedDate]!;
      });
      return;
    }

    try {
      var timeSlotsSnapshot = await _firestore
          .collection('alim_availability')
          .doc(widget.alimData)
          .collection('timeSlots')
          .doc(formattedDate) // Document ID is the date
          .get();

      if (timeSlotsSnapshot.exists) {
        List<Map<String, dynamic>> slots = List<Map<String, dynamic>>.from(timeSlotsSnapshot['slots']);
        setState(() {
          _timeSlots = slots;
          _cachedTimeSlots[formattedDate] = slots; // Cache the result
        });
      } else {
        setState(() {
          _timeSlots = [];
        });
      }
    } catch (e) {
      print('Error fetching time slots: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch time slots. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment'),
      ),
      body: Column(
        children: [
          // Calendar for selecting the date
          Expanded(
            flex: 2,
            child: SfCalendar(
              view: CalendarView.month,
              todayHighlightColor: TColors.primary,
              selectionDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              onSelectionChanged: (details) {
                setState(() {
                  _selectedDate = details.date;
                  _dateSelected = true;
                  _timeSelected = false; // Reset time selection
                  _selectedTimeIndex = null; // Clear selected time index
                });
                _fetchTimeSlotsForDate(); // Fetch slots for the selected date
              },
            ),
          ),
          if (_dateSelected)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Selected Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          if (_dateSelected)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Available Slots for ${_selectedDate?.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          // Time slots for the selected date
          if (_dateSelected)
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _timeSlots.isNotEmpty
                  ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _timeSlots.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTimeIndex = index;
                        _timeSelected = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedTimeIndex == index
                            ? TColors.primary
                            : Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "${_timeSlots[index]['startTime']} - ${_timeSlots[index]['endTime']}",
                          style: TextStyle(
                            color: _selectedTimeIndex == index
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  "No available slots for this date.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
          if (_dateSelected && _timeSelected)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: TColors.primary,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {
                  if (!_dateSelected || !_timeSelected) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a date and time slot.')),
                    );
                    return;
                  }

                  Get.to(
                        () => PaymentMethodPage(),
                    arguments: {
                      'selectedDate': _selectedDate!,
                      'selectedTimeSlot': _timeSlots[_selectedTimeIndex!],
                    },
                  );
                },
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}