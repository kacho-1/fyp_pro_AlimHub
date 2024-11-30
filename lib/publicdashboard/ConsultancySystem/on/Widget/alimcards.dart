import 'package:flutter/material.dart';

import '../../../../CommonFeatures/Customs/CustomColor.dart';

class AlimCards extends StatelessWidget {
   AlimCards({Key? key, required this.label, required this.value}) : super(key: key);
   final String label;
   final String value;
  @override
  Widget build(BuildContext context) {

    return  Expanded(
      child:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: TColors.primary,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,

        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),

            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),

            ),
          ],
        ),
      ),);
  }
}
