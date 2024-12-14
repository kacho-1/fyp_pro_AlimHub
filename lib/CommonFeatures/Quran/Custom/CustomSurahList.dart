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
     padding: const EdgeInsets.all(16),
     decoration: const BoxDecoration(
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
                 padding: const EdgeInsets.all(8),
                 decoration: const BoxDecoration(
                   shape: BoxShape.circle,
                   color:  Colors.black,

                 ),
                 child: Text((surah.number).toString(),
                 style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
               )

              ),
               const SizedBox(width: 20,),
               Expanded(
                 child: Column(
                   children: [
                     Text(surah.englishName!,
                       style:const TextStyle(
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
               const Spacer(),
               Expanded(
                 child: Text(surah.name!,
                   style: const TextStyle(
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