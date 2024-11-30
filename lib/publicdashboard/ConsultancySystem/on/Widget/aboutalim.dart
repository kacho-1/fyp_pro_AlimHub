import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/utility/config.dart';

class AboutAlim extends StatelessWidget {
  const AboutAlim({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65,
            backgroundImage: AssetImage('assets/images/alims/alim1.jpeg'),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text(
            'Molana Tariq Jameel'
          ,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize*0.75,
            child: Text('Maulana Tariq Jamil is a prominent Deobandi scholar who is also one of the most popular preachers in Pakistan. ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,

            ),
            softWrap: true,
            textAlign: TextAlign.center,),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize*0.75,
            child: Text('Well Known Scolar ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,

              ),
              softWrap: true,
              textAlign: TextAlign.center,),
          ),

 
        ],
      ),
    );
  }
}
