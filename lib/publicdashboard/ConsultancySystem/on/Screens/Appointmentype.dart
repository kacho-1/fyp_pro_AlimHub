import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Customs/CustomColor.dart';

class AppointmentType extends StatelessWidget {
  AppointmentType({super.key,required this.alimData});
   final alimData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Apointment Type',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),)),
      backgroundColor: TColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 14,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding:EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 6,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add,
                          color: TColors.primary,
                          size: 35,),
                        ),
                        SizedBox(height: 30,),
                        Text('Text-Based Consultancy',
                          style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white,

                          ) ,),
                        SizedBox(height: 5,),
                        Text('Make an Appointment',
                        style: TextStyle(
                          color: Colors.white54
                        ),),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding:EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 6,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add,
                            color: TColors.primary,
                            size: 35,),
                        ),
                        SizedBox(height: 30,),
                        Text('Video Call Consultancy',
                          style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white,

                          ) ,),
                        SizedBox(height: 5,),
                        Text('Make an Appointment',
                          style: TextStyle(
                              color: Colors.white54
                          ),),
                      ],
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
