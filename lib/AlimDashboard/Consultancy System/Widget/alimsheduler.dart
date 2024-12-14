import 'package:flutter/material.dart';

class AlimScheduleCard extends StatelessWidget {
  final String date;
  final String timeSlot;

  const AlimScheduleCard({super.key, required this.date, required this.timeSlot});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.calendar_today, color: Colors.white, size: 15),
          const SizedBox(width: 5),
          Text(date, style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 20),
          const Icon(Icons.access_alarm, color: Colors.white, size: 17),
          const SizedBox(width: 5),
          Flexible(
            child: Text(timeSlot, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
