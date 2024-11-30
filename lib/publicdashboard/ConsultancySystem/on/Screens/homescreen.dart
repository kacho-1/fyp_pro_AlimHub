import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/AppointCard.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/alimcard.dart';

class ConsultancyHome extends StatelessWidget {
   ConsultancyHome({super.key});
  List img = [
    'assets/images/alims/alim1.jpeg'
        'assets/images/alims/alim2.jpeg'
        'assets/images/alims/alim3.jpeg'
        'assets/images/alims/alim4.jpeg'

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Alim List',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),)),
        backgroundColor: TColors.primary,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 14,),
                Text('Appointment Todays',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 25,),
                AppointmentCard(),
                SizedBox(height: 25,),
                Text('Top Alims',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 25,),
                Column(
                  children:List.generate(10, (index) {
                    return AlimCard();
                  }),
                )


              ],
            ),
          )),

    );
  }
}
