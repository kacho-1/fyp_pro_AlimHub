import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/service/api_service.dart';

import '../../Customs/CustomColor.dart';
import '../Custom/AudioTile.dart';
import '../Models/QariModel.dart';
import '../Models/SurahModel.dart';
import 'AudioScreen.dart';

class AudioSurahScreen extends StatefulWidget {
  const AudioSurahScreen({super.key, required this.qari});
  final Qari qari;
  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: TColors.primary,
          elevation: 0,
          title: const Text('Surah List',
          style: TextStyle(
            color: Colors.white,fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
        ),
        body: FutureBuilder(
            future:apiServices.getSurah(),
            builder: (BuildContext context,
            AsyncSnapshot<List<Surah>> snapshot){
              if (snapshot.hasData){
                List<Surah>? surah =snapshot.data;
                return ListView.builder(
                    itemCount: surah!.length,
                    itemBuilder: (context,index)=>
                        AudioTile(surahName:snapshot.data![index].englishName,
                        totalAya: snapshot.data![index].numberOfAyahs,
                        number: snapshot.data![index].number,
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioScreen(
                            qari: widget.qari,
                            index: index+1,
                            list: surah,
                          )));
                        })
                );
              }
              return const Center(
                child:  CircularProgressIndicator(),
              );
            }
        ),
      ),
    );
  }
}
