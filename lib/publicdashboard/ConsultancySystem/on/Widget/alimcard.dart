import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Screens/alimdetailscreen.dart';

import '../utility/config.dart';

class AlimCard extends StatefulWidget {
  const AlimCard({super.key});

  @override
  State<AlimCard> createState() => _AlimCardState();
}

class _AlimCardState extends State<AlimCard> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.33,
              child: Image.asset('assets/images/alims/alim1.jpeg',fit: BoxFit.fill,),),
             Flexible(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(
                     'Molana Tariq Jameel',
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.normal,
                 ),),
                 Spacer(),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Icon(Icons.star_border,
                     color: Colors.yellow,
                     size: 16,),
                     Spacer(flex: 1,),
                     Text('4.5'),
                     Spacer(flex: 1,),
                     Text('Reviews'),
                     Spacer(flex: 1,),
                     Text('(20)'),
                     Spacer(flex: 7,),
                     Text('Fee: 1000')
                   ],
                 ),

               ],
             ),),
             ),

            ],
          ),
        ),
        onTap: (){
         Navigator.push(context,
         MaterialPageRoute(builder: (context)=>AlimDetailScreen()));
        },
      ),
    );
  }
}
