import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../CommonFeatures/Customs/CustomColor.dart';
import '../controller.dart';

class AvailabilityCard extends StatelessWidget {
  final DateTime date;
  final AlimAvailabilityController controller;

  const AvailabilityCard({
    required this.date,
    required this.controller, required List<Map<String, dynamic>> timeSlots,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        side: BorderSide(
          color: TColors.primary, // Border color
          width: 2.0, // Border width
        ),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display selected date
            Text(
              'Date: ${DateFormat('yyyy-MM-dd').format(date)} (${DateFormat('EEEE').format(date)})',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Display available time slots
            Obx(() {
              final slots = controller.timeSlots[date] ?? [];
              return Column(
                children: slots.map((slot) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                        ),
                        child: ListTile(
                          title: Text(
                            '${slot['startTime']} - ${slot['endTime']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit_outlined, color: Colors.white),
                                onPressed: () =>
                                    _showEditSlotDialog(context, date, slot),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    controller.deleteSlot(date, slot['startTime'])
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              );
            }),
            SizedBox(height: 8.0),
            // Add time slot button
            Center(
              child: ElevatedButton(
                onPressed: () => _showAddSlotDialog(context, date),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: TColors.primary,
                  minimumSize: Size(140, 50),
                ),
                child: Text(
                  'Add Time Slot',
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
      ),
    );
  }

  // Dialog to add a new slot
  void _showAddSlotDialog(BuildContext context, DateTime date) {
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Time Slot'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: startTimeController,
                decoration: InputDecoration(
                  labelText: 'Start Time (HH:mm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 15),
              TextField(
                controller: endTimeController,
                decoration: InputDecoration(
                  labelText: 'End Time (HH:mm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: TColors.primary),
              onPressed: () {
                final startTime = startTimeController.text;
                final endTime = endTimeController.text;
                if (startTime.isNotEmpty && endTime.isNotEmpty) {
                  controller.addSlot(date, startTime, endTime);
                  Navigator.pop(context);
                } else {
                  Get.snackbar('Error', 'Please fill in all fields.');
                }
              },
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Dialog to edit an existing slot
  // Dialog to edit an existing slot
  void _showEditSlotDialog(BuildContext context, DateTime date, Map<String, dynamic> slot) {
    // Initialize controllers with the current start and end times
    final startTimeController = TextEditingController(text: slot['startTime']);
    final endTimeController = TextEditingController(text: slot['endTime']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Time Slot'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: startTimeController,
                decoration: InputDecoration(labelText: 'Start Time (HH:mm)', border: OutlineInputBorder()),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 15),
              TextField(
                controller: endTimeController,
                decoration: InputDecoration(labelText: 'End Time (HH:mm)', border: OutlineInputBorder()),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: TColors.primary),
              onPressed: () {
                final startTime = startTimeController.text;
                final endTime = endTimeController.text;
                if (startTime.isNotEmpty && endTime.isNotEmpty) {
                  // Call editSlot with the necessary parameters
                  controller.editSlot(date, slot['startTime'], startTime, endTime);
                  Navigator.pop(context);
                } else {
                  Get.snackbar('Error', 'Please fill in all fields.');
                }
              },
              child: Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

}
