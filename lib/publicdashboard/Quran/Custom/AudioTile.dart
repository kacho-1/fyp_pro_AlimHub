import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';

class AudioTile extends StatelessWidget {
   AudioTile({super.key
  ,
  required this.surahName,
  required this.number,
  required this.totalAya,
  required this.onTap});
  String? surahName;
  final totalAya;
  final number;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black12,
              offset: Offset(0, 3),
            ),
          ]
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black
              ),
              child: Text(number.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                surahName!,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 3,),
                Text('Total Aya : $totalAya',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),)
              ],
            ),
            Spacer(),
            Icon(Icons.play_circle_fill, color: TColors.primary,),
          ],
        ),
      ),),
    );
  }
}
