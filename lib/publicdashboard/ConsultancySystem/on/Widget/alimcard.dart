import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Screens/alimdetailscreen.dart';

class AlimCard extends StatelessWidget {
  final String alimName;
  final String alimImage;
  final String alimFee;
  final String alimUid;

  const AlimCard({super.key, 
    required this.alimName,
    required this.alimImage,
    required this.alimFee,
    required this.alimUid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: 100, // Set a fixed width for image
                child: Image.network(
                  alimImage,
                  fit: BoxFit.fill,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        alimName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          const Spacer(),
                          const Text('4.5'),
                          const Spacer(),
                          const Text('Reviews'),
                          const Spacer(),
                          const Text('(20)'),
                          const Spacer(),
                          Text('Fee: $alimFee')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlimDetailScreen(alimUid: alimUid),
            ),
          );
        },
      ),
    );
  }
}
