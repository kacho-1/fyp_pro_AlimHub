import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Screens/paymnetmethod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../CommonFeatures/Customs/CustomColor.dart';


class AlimBookingPage extends StatefulWidget {
  const AlimBookingPage({super.key});

  @override
  State<AlimBookingPage> createState() => _AlimBookingPageState();
}

class _AlimBookingPageState extends State<AlimBookingPage> {
  DateTime? _selectedDate;
  bool _dateSelected = false;
  bool _timeSelected = false;
  int? _selectedTimeIndex;

  // Mock time slots (to be dynamically set later)
  final List<String> _timeSlots = [
    '10:00 AM - 10:30 AM',
    '11:00 AM - 11:30 AM',
    '12:00 PM - 12:30 PM',
    '02:00 PM - 02:30 PM',
    '03:00 PM - 03:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text(
          'Appointment',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          // Calendar for selecting the date
          Expanded(
            flex: 2,
            child: SfCalendar(
              view: CalendarView.month,
              todayHighlightColor: TColors.primary,
              selectionDecoration: BoxDecoration(
                //color: Colors.grey[300].opacity, // Light grey color for the selected date
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              onSelectionChanged: (CalendarSelectionDetails details) {
                setState(() {
                  _selectedDate = details.date;
                  _dateSelected = true;
                  _timeSelected = false; // Reset time selection on new date
                  _selectedTimeIndex = null; // Clear previously selected time
                });
              },
            ),
          ),
          // Display the selected date
          if (_dateSelected)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Selected Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          if (_dateSelected)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Available Slots for ${_selectedDate?.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          // Time slots for the selected date
          if (_dateSelected)
            Container(
              height: 100, // Set height for the horizontal scroll view
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
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
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          _timeSlots[index],
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
              ),
            ),
          // Confirm button
          if (_dateSelected && _timeSelected)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: TColors.primary,
                minimumSize: Size (200,50),

               ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethodPage()));
                  // Confirmation logic to be implemented later
                 /* final selectedTime = _timeSlots[_selectedTimeIndex!];
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirm Appointment"),
                      content: Text(
                          "Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}\nTime: $selectedTime"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Placeholder for booking logic
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Appointment Confirmed!"),
                              ),
                            );
                          },
                          child: const Text("Confirm"),
                        ),
                      ],
                    ),
                  );*/
                },
                child: const Text("Proceed to Payment",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
              ),
            ),
        ],
      ),
    );
  }
}
