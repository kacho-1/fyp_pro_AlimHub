import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/alimcards.dart';

import '../../../../CommonFeatures/Customs/CustomColor.dart';

class AlimInfo extends StatelessWidget {
  final alimexperience;
  const AlimInfo({super.key,required this.alimexperience});

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
            value: ' ${alimexperience} years'),
        SizedBox(width: 15,),
        AlimCards(
            label: 'Rating' ,
            value: '4.8'),


      ],
    );
  }
}
