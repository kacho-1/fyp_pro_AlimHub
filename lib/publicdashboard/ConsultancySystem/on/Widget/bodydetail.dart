import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/aliminfo.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/utility/config.dart';

class DetailBody extends StatelessWidget {
  final String aboutAlim;
  final String alimExperience;


  const DetailBody({
    super.key,
    required this.aboutAlim,
    required this.alimExperience,
  });

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          AlimInfo(alimexperience: alimExperience,

          ), // Keep this as is, or modify based on available data
          Config.spaceBig,
          const Text(
            'About Alim',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Config.spaceSmall,
          Text(
            aboutAlim, // Display alim's description
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: Colors.grey,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
          Config.spaceSmall,

        ],
      ),
    );
  }
}
