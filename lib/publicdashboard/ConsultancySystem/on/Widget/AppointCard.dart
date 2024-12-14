import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Customs/CustomColor.dart';

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
        child: Padding(padding: const EdgeInsets.all(20),
        child: Column(
          children:<Widget> [
            const Row(
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
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancel',
                      style:TextStyle(
                        color: Colors.white,
                      ) ,),
                  ),
                ),
                const SizedBox(width: 20,),


                Expanded(
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Completed',
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
