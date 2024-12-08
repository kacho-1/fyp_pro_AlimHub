import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/utility/config.dart';

class AboutAlim extends StatelessWidget {
  final String alimName;
  final String alimImage;
  final String alimSpecialty;

  const AboutAlim({Key? key, required this.alimName, required this.alimImage,required this.alimSpecialty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65,
            backgroundImage: NetworkImage(alimImage), // Display alim's image from URL
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text(
            alimName, // Display alim's name dynamically
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: Text(
              alimSpecialty, // You can update this to show alim's field or specialty
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
