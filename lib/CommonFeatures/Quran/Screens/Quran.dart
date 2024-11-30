import 'package:flutter/material.dart';

import '../../../publicdashboard/service/api_service.dart';
import '../../Customs/CustomColor.dart';
import '../Constants.dart';
import '../Custom/CustomSurahList.dart';
import '../Juz/Juz.dart';
import '../Models/SurahModel.dart';
import '../Surah/surah_detail.dart';
class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child:SafeArea(child: Scaffold(
          appBar:AppBar(
            title: Text('Quran',style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),),
            centerTitle: true,
            backgroundColor: TColors.primary,
            bottom: TabBar(
                tabs: [
                  Text('Surah',
                    style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),),
                  Text('Juz',
                    style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),),
                  //Text(data),
                 // Text(data),
                ]),
          ),

          body: TabBarView(
              children: <Widget>[
               FutureBuilder(
                   future: apiServices.getSurah(),
                   builder: (BuildContext context,AsyncSnapshot <List<Surah>> snapshot)
               {
                 if (snapshot.hasData){
                   List<Surah>? surah =snapshot.data;
                   return ListView.builder(
                     itemCount: surah!.length,
                       itemBuilder:(context,index)=>SurahCustomListile(surah:surah[index],
                           context: context,
                           ontap: () {
                         setState(() {
                           Constants.surahIndex = (index+1);
                         });
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context)=>Surahdetail())
                         );
                           }),

                   );
               }
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               },),

                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemCount: 30,
                        itemBuilder: (context,index)
                    {
                      return GestureDetector(
                        onTap: (){
                         setState(() {
                          Constants.juzIndex = (index+1);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>JuzScreen()));
                         });
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.blueGrey,
                          child: Center(
                            child: Text('${index+1}',style: TextStyle(color: Colors.white,fontSize: 20),),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ]
          )
        )));
  }
}
