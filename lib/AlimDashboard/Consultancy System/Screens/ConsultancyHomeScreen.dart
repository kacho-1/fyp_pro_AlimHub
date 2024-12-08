import 'package:flutter/material.dart';

import '../../../CommonFeatures/Customs/CustomColor.dart';
import '../../../publicdashboard/ConsultancySystem/on/Widget/ScheduleCard.dart';
import '../../../publicdashboard/ConsultancySystem/on/utility/config.dart';

class ConsultancyHomeScreen extends StatefulWidget {
  const ConsultancyHomeScreen({super.key});

  @override
  State<ConsultancyHomeScreen> createState() => _ConsultancyHomeScreenState();
}
enum FilterStatus {upcoming,completed,cancel}
class _ConsultancyHomeScreenState extends State<ConsultancyHomeScreen> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      'alim_name':'Molana Tariq Jameel',
      'alim_profile':'assets/images/alims/alim1.jpeg',
      'status':FilterStatus.upcoming,
    },
    {
      'alim_name':'Molana Asim Ali',
      'alim_profile':'assets/images/alims/alim2.jpeg',
      'status':FilterStatus.upcoming,
    },
    {
      'alim_name':'Molana Ahsan Hussain',
      'alim_profile':'assets/images/alims/alim3.jpeg',
      'status':FilterStatus.completed,
    },
    {
      'alim_name':'Enggineer Mirza Ali ',
      'alim_profile':'assets/images/alims/alim4.jpeg',
      'status':FilterStatus.cancel,
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule){
      /* switch (schedule['status']){
        case 'upcoming':
          schedule['status'] = FilterStatus.upcoming;
          break;
        case 'complete':
          schedule['status'] = FilterStatus.completed;
          break;
        case 'cancel':
          schedule['status'] = FilterStatus.cancel;
          break;
      }*/
      return schedule['status'] == status;
    }
    ).toList();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 20,top: 20,right: 20)
        ,child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Text('Apointment Schedule',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,

            ),
            textAlign: TextAlign.center,
          ),
          Config.spaceSmall,
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (FilterStatus filterstatus in FilterStatus.values)
                      Expanded(child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(filterstatus == FilterStatus.upcoming)
                            {
                              status = FilterStatus.upcoming;
                              _alignment = Alignment.centerLeft;
                            }
                            else if (filterstatus == FilterStatus.completed)
                            {

                              status = FilterStatus.completed;
                              _alignment = Alignment.center;

                            }
                            else if (filterstatus == FilterStatus.cancel)
                            {
                              status = FilterStatus.cancel;
                              _alignment = Alignment.centerRight;
                            }
                          });
                        },
                        child: Center(
                          child: Text(filterstatus.name),
                        ),
                      ))
                  ],
                ),
              ),
              AnimatedAlign(
                alignment:_alignment ,
                duration: Duration(milliseconds: 200),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      status.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Config.spaceSmall,
          Expanded(
              child: ListView.builder(
                  itemCount: filteredSchedules.length,
                  itemBuilder:((context,index){
                    var _schedule = filteredSchedules[index];
                    bool isLastElement = filteredSchedules.length + 1 == index;
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey,

                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: !isLastElement
                          ? EdgeInsets.only(bottom: 20,)
                          : EdgeInsets.zero,
                      child: Padding(
                        padding:EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(_schedule['alim_profile']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _schedule['alim_name'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SheduleCard(),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      onPressed: (){},
                                      child:Text(
                                        'Cancel'
                                        ,
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.red
                                      )
                                  ),),
                                SizedBox(
                                  width: 20,
                                ),

                                Expanded(
                                  child: OutlinedButton(
                                      onPressed: (){},
                                      child:Text(
                                        'Completed'
                                        ,
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.blue
                                      )
                                  ),),

                              ],
                            )
                          ],
                        ),),

                    );
                  })
              )
          ),
        ],

      ),),
    );

  }
}
