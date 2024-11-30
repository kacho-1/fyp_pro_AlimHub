import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/SurahModel.dart';

Widget SurahCustomListile({
  required Surah surah,
  required BuildContext context,
  required VoidCallback ontap,
})
{
 return GestureDetector(
   onTap: ontap,
   child: Container(
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
     child:Column(
       children: [
         Row(
             children: [
               Container(
                 alignment: Alignment.center,
                 height: 40,
                 width: 50,
                 padding: EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color:  Colors.black,

                 ),
                 child: Text((surah.number).toString(),
                 style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
               )

              ),
               SizedBox(width: 20,),
               Expanded(
                 child: Column(
                   children: [
                     Text(surah.englishName!,
                       style:TextStyle(
                         fontWeight: FontWeight.bold,

                       )
                       ,
                       maxLines: 1, // Limit the number of lines
                       overflow: TextOverflow.ellipsis,),
                     Text(surah.englishNameTranslation!,
                       maxLines: 1, // Limit the number of lines
                       overflow: TextOverflow.ellipsis,),
                   ],
                 ),
               ),
               Spacer(),
               Expanded(
                 child: Text(surah.name!,
                   style: TextStyle(
                     color: Colors.black54,
                     fontWeight: FontWeight.bold,fontSize: 20
                   ), maxLines: 2, // Limit the number of lines
                   overflow: TextOverflow.ellipsis,),
               )

             ],

           ),
       ],
     )
 
   ),
 ) ;
}