import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Quran/Constants.dart';
import 'package:fyp_pro/publicdashboard/Quran/Models/JusModel.dart';
import 'package:fyp_pro/publicdashboard/service/api_service.dart';

import '../Custom/CustomJuztile.dart';

class JuzScreen extends StatelessWidget {
  //const JuzScreen({super.key});
  static const String id ='juz_screen';
ApiServices apiServices =ApiServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: FutureBuilder<JuzModel>(
              future:apiServices.getJuzz(Constants.juzIndex!) ,
              builder: (context, AsyncSnapshot<JuzModel> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);

                }
                else if (snapshot.hasData){
                  print('${snapshot.data!.jusAyahs.length} length');
                  return ListView.builder(
                      itemCount: snapshot.data!.jusAyahs.length,
                      itemBuilder: (context, index){
                         return CustomJuzTile(list: snapshot.data!.jusAyahs,index:index,);
                      },
                  );
                }
                else {
                  return Center(child: Text('Data donot found'),);
                }
              }
          ),
        )
    );
  }
}
