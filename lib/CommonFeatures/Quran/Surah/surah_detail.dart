import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/service/api_service.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../Customs/CustomColor.dart';
import '../Constants.dart';
import '../Custom/CustomTranslationTile.dart';
import '../Models/translationModel.dart';

enum Translation {urdu,hindi,english,turkish,persian,german}

class Surahdetail extends StatefulWidget {
  const Surahdetail({super.key});

  static const String id = 'surahDetail_screen';
  @override
  State<Surahdetail> createState() => _SurahdetailState();
}

class _SurahdetailState extends State<Surahdetail> {
  ApiServices apiServices = ApiServices();
  SolidController controller = SolidController();
  Translation translation =Translation.urdu;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: apiServices.getTranslation(Constants.surahIndex!,translation.index),
            builder: (BuildContext context,
            AsyncSnapshot<SurahTranslationList>snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ListView.builder(
                      itemCount: snapshot.data!.translationList.length,
                      itemBuilder: (context,index)
                  {
                    return TranslationTile(index:index,
                    surahTranslation:snapshot.data!.translationList[index]);
                  }),
                );
              }
              else return const Center(
                  child: Text("Translation Not Found") ,
                );
            },

        ),
        bottomSheet: SolidBottomSheet(
            headerBar: Container(
              color: TColors.primary,
              height: 50,
              child: const Center(
                child: Text("Swipe me!",
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
            body: Container(
              color: Colors.white,
              height: 30,
              child: SingleChildScrollView(
                child: Center(
                  child:Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Urdu'),
                        leading: Radio<Translation>(
                          value: Translation.urdu,
                          groupValue: translation,
                          onChanged: (Translation? value){
                            setState(() {
                              translation = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Hindi'),
                        leading: Radio<Translation>(
                          value: Translation.hindi,
                          groupValue: translation,
                          onChanged: (Translation? value){
                            setState(() {
                              translation = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('English'),
                        leading: Radio<Translation>(
                          value: Translation.english,
                          groupValue: translation,
                          onChanged: (Translation? value){
                            setState(() {
                              translation = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Turkish'),
                        leading: Radio<Translation>(
                          value: Translation.turkish,
                          groupValue: translation,
                          onChanged: (Translation? value){
                            setState(() {
                              translation = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Persian'),
                        leading: Radio<Translation>(
                          value: Translation.persian,
                          groupValue: translation,
                          onChanged: (Translation? value){
                            setState(() {
                              translation = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('German'),
                        leading: Radio<Translation>(
                          value: Translation.german,
                          groupValue: translation,
                          onChanged: (Translation? value){
                            setState(() {
                              translation = value!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
