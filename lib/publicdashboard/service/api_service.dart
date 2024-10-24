
import 'dart:convert';

import 'package:fyp_pro/publicdashboard/Quran/Models/JusModel.dart';
import 'package:fyp_pro/publicdashboard/Quran/Models/QariModel.dart';
import 'package:fyp_pro/publicdashboard/Quran/Models/translationModel.dart';
import 'package:fyp_pro/publicdashboard/Quran/Models/SurahModel.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final endpointUrl = "http://api.alquran.cloud/v1/surah";
  List <Surah> list = [];

  Future <List<Surah>> getSurah() async{


  Response res =  await http.get

  (

  Uri.parse(endpointUrl));
  if (res.statusCode == 200){
  Map<String,dynamic> json = jsonDecode(res.body);
    json ['data'].forEach((element)
  {
  if (list.length<114)
  {
  list.add(Surah.fromJson(element));
  }

  });
  print('ol ${list.length}');
  return list;
  }
  else
  {
  throw ('cannot get the surah');
  }
}
Future <JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200){
      return JuzModel.fromJSON(json.decode(response.body));
    }else{
      print('failed to load');
      throw Exception('failed to load Post');
    }
}

Future<SurahTranslationList> getTranslation(int index, int translationIndex) async{
    String lan = '';
    if (translationIndex == 0)
      {
        lan='urdu_junagarhi';
      }
    else if(translationIndex==1){
      lan='hindi_omari';
    }
    else if (translationIndex==2){
      lan='english_saheeh';
    }
    else if (translationIndex==3){
      lan='turkish_shaban';
    }
    else if (translationIndex==4){
      lan='persian_mokhtasar';
    }
    else if (translationIndex==5){
      lan='german_aburida';
    }


    final url = 'https://quranenc.com/api/translation/sura/$lan/$index';
    var res = await http.get(Uri.parse(url));
    return SurahTranslationList.fromJson(json.decode(res.body));
}

  Future<List<Qari>> getQariList() async {
    List<Qari> qariList = [];
    final url = "https://quranicaudio.com/api/qaris";

    try {
      // Add any required headers here
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add any other headers that might be required
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        data.forEach((element) {
          qariList.add(Qari.fromjson(element));
        });
        return qariList;
      } else {
        throw Exception('Failed to load Qari list. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Qari list: $e');
      throw e; // Propagate the error
    }
  }

/*List<Qari> qarilist =[];
Future<List<Qari>> getQariList() async{
    final url = "https://quranicaudio.com/api/qaris";
    final res = await http.get(Uri.parse(url));
    jsonDecode(res.body).forEach((element){
      if(qarilist.length<20)
        qarilist.add(Qari.fromjson(element));
    });
    qarilist.sort((a,b)=>a.name!.compareTo(b.name!));
    return qarilist;
}*/
}



