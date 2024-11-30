import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/aliminfo.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/utility/config.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Config.spaceSmall,
          AlimInfo(),
          Config.spaceBig,
          Text('About Alim',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),),
          Config.spaceSmall,
          Text('Maulana Tariq Jamil is a prominent Deobandi scholar who is also one of the most popular preachers in Pakistan. He belongs to the Tablighi Jamaat group.',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            height: 1.5,

          ),
          softWrap: true,
              textAlign: TextAlign.justify,)
        ],
      ),
    );
  }
}
