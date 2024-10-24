import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Quran/Models/JusModel.dart';

class CustomJuzTile extends StatelessWidget{
  final List <JuzAyahs> list;
  final int index;

  CustomJuzTile({required this.list, required this.index});

  @override
  Widget build (BuildContext context)
  {
   return Container(
     padding: EdgeInsets.all(16),
     decoration: BoxDecoration(
       color: Colors.white,
       boxShadow: [
         BoxShadow(
           color: Colors.black12,
           blurRadius: 3,
         )
       ]


     ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.end,
       children: [
         Text(list[index].ayahNumber.toString()),
         Text(list[index].ayahsText,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),textAlign: TextAlign.end),
          Text(list[index].surahName,textAlign: TextAlign.end,)
       ],
     ),
   );
  }

}