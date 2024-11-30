import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/aboutalim.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/bodydetail.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/consultancytypes.dart';
class AlimDetailScreen extends StatefulWidget {
  const AlimDetailScreen({super.key});

  @override
  State<AlimDetailScreen> createState() => _AlimDetailScreenState();
}

class _AlimDetailScreenState extends State<AlimDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text('Alim Detail',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,

        ),),

      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                AboutAlim(),
                DetailBody(),
               SizedBox(
                 height: 12,
               ),
                Center(

                  child: Padding(
                      padding: EdgeInsets.all(20),
                  child: ElevatedButton(

                      onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>ConsultationTypePage()));
                      } ,
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: TColors.primary,
                        minimumSize: Size (200,50),
                        
                      ),
                      child: Text('Book Appointment',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),))
                  ),
                ),
        
              ],
            )
        ),
      ),


    );
  }
}
