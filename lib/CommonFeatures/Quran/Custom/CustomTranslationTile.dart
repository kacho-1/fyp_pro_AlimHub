import 'package:flutter/material.dart';

import '../Constants.dart';
import '../Models/translationModel.dart';
class TranslationTile extends StatelessWidget{
  final SurahTranslation surahTranslation;
  final int index;

  const TranslationTile({super.key, required this.surahTranslation, required this.index});

  @override
  Widget build (BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
              ),
            ]
      
      
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Constants.kPrimary,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                ),
                Positioned(
                  top: 3,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,

                      ),
                      child: Text(surahTranslation.aya!,
                      style: const TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(surahTranslation.arabic_text!,
                textAlign: TextAlign.end,
                style:  const TextStyle(
                  fontSize:20, 
                  fontWeight : FontWeight.bold,
                  color: Colors.black54,

                ),),
                Text(surahTranslation.translation!,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),)
              ],),
            )

          ],
        ),
      ),
    );
  }

}