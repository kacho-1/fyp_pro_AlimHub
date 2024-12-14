import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/alimcards.dart';


class AlimInfo extends StatelessWidget {
  final alimexperience;
  const AlimInfo({super.key,required this.alimexperience});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const AlimCards(
            label: 'Seekers' ,
            value: '55'),
        const SizedBox(width: 15,),
        AlimCards(
            label: 'Experences' ,
            value: ' $alimexperience years'),
        const SizedBox(width: 15,),
        const AlimCards(
            label: 'Rating' ,
            value: '4.8'),


      ],
    );
  }
}
