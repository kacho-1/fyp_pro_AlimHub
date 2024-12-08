import 'package:flutter/material.dart';
import 'package:fyp_pro/CommonFeatures/Customs/CustomColor.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Controller/DataFetching%20controller.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Widget/alimcard.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/Screens/alimdetailscreen.dart';
import 'package:get/get.dart';

class ConsultancyHome extends StatefulWidget {
  ConsultancyHome({super.key});

  @override
  State<ConsultancyHome> createState() => _ConsultancyHomeState();
}

class _ConsultancyHomeState extends State<ConsultancyHome> {
  final DataFetchController controller = Get.put(DataFetchController());
  final TextEditingController searchController = TextEditingController();
  List<dynamic> filteredAlimList = [];

  @override
  void initState() {
    super.initState();
    controller.fetchAlimAvailability();
    // Initially, the filtered list is the same as alimList
    filteredAlimList = controller.alimList;
  }

  void filterAlims(String query) {
    // Filter the alimList based on the query
    final filtered = controller.alimList.where((alim) {
      return alim.alimName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredAlimList = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Alim List',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: TColors.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: TColors.textWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white)),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: TColors.primary),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: filterAlims,  // Trigger the filter function on text change
                          decoration: InputDecoration(
                            hintText: 'Search for an Alim...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                'Top Alims',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              // Using Obx to watch changes in alimList
              Obx(() {
                // Check if alimList is empty or still loading
                if (controller.alimList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: filteredAlimList.map((alim) {
                      return AlimCard(
                        alimName: alim.alimName,
                        alimImage: alim.alimImage,
                        alimFee: alim.fee,
                        alimUid: alim.alimUid,
                      );
                    }).toList(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
