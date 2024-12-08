import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/aboutalim.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/bodydetail.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/consultancytypes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AlimDetailScreen extends StatefulWidget {
  final String alimUid;

  const AlimDetailScreen({Key? key, required this.alimUid}) : super(key: key);

  @override
  State<AlimDetailScreen> createState() => _AlimDetailScreenState();
}

class _AlimDetailScreenState extends State<AlimDetailScreen> {
  var alimData = {}.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchAlimData();
  }

  // Fetch Alim data based on alimUid
  Future<void> _fetchAlimData() async {
    try {
      var alimSnapshot = await _firestore
          .collection('alim_availability')
          .doc(widget.alimUid)
          .get();

      if (alimSnapshot.exists) {
        alimData.value = alimSnapshot.data()!;
      }
    } catch (e) {
      print('Error fetching Alim data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text(
          'Alim Detail',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(() {
            if (alimData.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: <Widget>[
                SizedBox(height: 15),
                AboutAlim(
                  alimName: alimData['alimname'],
                  alimImage: alimData['alimimage'],
                  alimSpecialty: alimData['specialty'],
                ),
                DetailBody(
                  aboutAlim: alimData['about'],
                  alimExperience: alimData['experience'],
                ),
                SizedBox(height: 12),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConsultationTypePage(alimUid: alimData['alimUid']),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: TColors.primary,
                        minimumSize: Size(200, 50),
                      ),
                      child: Text(
                        'Book Appointment',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
