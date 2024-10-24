
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/Quran/Custom/CustomQaitile.dart';
import 'package:fyp_pro/publicdashboard/Quran/Models/QariModel.dart';
import 'package:fyp_pro/publicdashboard/Quran/Screens/audio_surah_screen.dart';
import 'package:fyp_pro/publicdashboard/service/api_service.dart';

class AudioQuranScreen extends StatefulWidget {
  const AudioQuranScreen({super.key});

  @override
  State<AudioQuranScreen> createState() => _AudioQuranScreenState();
}

class _AudioQuranScreenState extends State<AudioQuranScreen> {
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Qari\'s',style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold),),
              centerTitle: true,
            backgroundColor: TColors.primary,

          ),
          body: Padding(
              padding: EdgeInsets.only(top: 20,
              left: 12,right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 1,
                      spreadRadius: 0.0,
                      offset: Offset(0,1),
                    ),
                  ]
                ),
                child: Padding(
                    padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text('Search'),
                    Spacer(),
                    Icon(Icons.search),
                  ],
                ),),
              ),
              SizedBox(height: 20,),
              Expanded(
                  child:FutureBuilder(
                      future: apiServices.getQariList(),
                      builder: (BuildContext context,AsyncSnapshot <List<Qari>> snapshot){
                       if(snapshot.hasError){
                         print("Error: ${snapshot.error}"); //chatgpt
                         return Center(child: Text('Qari\'s data not found'),);
                       }
                       if(snapshot.connectionState==ConnectionState.waiting){
                         return Center(
                           child: CircularProgressIndicator(),
                         );
                       }
                       return ListView.builder(
                           itemCount: snapshot.data!.length,
                           itemBuilder: (context,index){
                             return QariCustomTile(qari: snapshot.data![index],
                             ontap: (){
                               Navigator.push(context,
                               MaterialPageRoute(builder: (context)=>AudioSurahScreen(qari: snapshot.data![index])));
                             });
                           }
                       );
                      }
                  )
              ),
            ],

          ),),
    ));
  }
}
