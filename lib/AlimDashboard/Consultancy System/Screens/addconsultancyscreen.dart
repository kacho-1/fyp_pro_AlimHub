import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../CommonFeatures/Customs/CustomColor.dart';
import '../Widget/AvailbilityCard.dart';
import '../controller.dart';

class AlimAvailabilityScreen extends StatelessWidget {
  final AlimAvailabilityController controller =
  Get.put(AlimAvailabilityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Availability'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextField(
              controller: TextEditingController(
                  text: controller.dateFieldText.value),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Select Date',
                hintText: 'Choose a date',
                suffixIcon: Icon(Icons.calendar_today_outlined),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: TColors.primary, width: 2.0),
                ),
              ),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Colors.grey,
                        dialogBackgroundColor: Colors.white,
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(secondary: TColors.primary),
                      ),
                      child: child!,
                    );
                  },
                );

                if (selectedDate != null) {
                  controller.addSelectedDate(selectedDate);
                }
              },
            )),
            SizedBox(height: 16.0),
            Obx(() => Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: controller.selectedDates
                  .map((date) => Chip(
                label: Text(
                    '${DateFormat('yyyy-MM-dd').format(date)} (${DateFormat('EEEE').format(date)})'),
                deleteIcon: Icon(Icons.close),
                onDeleted: () => controller.removeSelectedDate(date),
              ))
                  .toList(),
            )),
            SizedBox(height: 16.0),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.selectedDates.length,
                itemBuilder: (context, index) {
                  DateTime date = controller.selectedDates[index];
                  List<Map<String, dynamic>> slots =
                      controller.timeSlots[date] ?? [];
                  return AvailabilityCard(
                    date: date,
                    timeSlots: slots,
                    controller: controller,
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
