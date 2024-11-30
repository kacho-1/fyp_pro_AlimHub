import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/alimcards.dart';

import '../../../../CommonFeatures/Customs/CustomColor.dart';

class AlimInfo extends StatelessWidget {
  const AlimInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AlimCards(
            label: 'Seekers' ,
            value: '55'),
        SizedBox(width: 15,),
        AlimCards(
            label: 'Experences' ,
            value: '10 years'),
        SizedBox(width: 15,),
        AlimCards(
            label: 'Rating' ,
            value: '4.8'),


      ],
    );
  }
}
