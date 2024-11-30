import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/ScheduleCard.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.white54,
        child: Padding(padding: EdgeInsets.all(20),
        child: Column(
          children:<Widget> [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  AssetImage('assets/images/alims/alim1.jpeg'),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Molana Tariq Jameel',
                      style:TextStyle(
                        color: Colors.white,

                      ) ,
                    ),

                  ],
                ),

              ],
            ),
            SizedBox(height: 25,),
            SheduleCard(),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Cancel',
                      style:TextStyle(
                        color: Colors.white,
                      ) ,),
                  ),
                ),
                SizedBox(width: 20,),


                Expanded(
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Completed',
                      style:TextStyle(
                        color: Colors.white,
                      ) ,),
                  ),
                ),

              ],
            )


          ],
        ),
        ),
      ),
    );
  }
}
