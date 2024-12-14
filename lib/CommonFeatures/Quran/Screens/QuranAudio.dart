import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/service/api_service.dart';

import '../../Customs/CustomColor.dart';
import '../Custom/CustomQaitile.dart';
import '../Models/QariModel.dart';
import 'audio_surah_screen.dart';

class AudioQuranScreen extends StatefulWidget {
  const AudioQuranScreen({super.key});

  @override
  State<AudioQuranScreen> createState() => _AudioQuranScreenState();
}

class _AudioQuranScreenState extends State<AudioQuranScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  List<Qari> allQariList = [];
  List<Qari> filteredQariList = [];

  @override
  void initState() {
    super.initState();
    fetchQariList();
  }

  void fetchQariList() async {
    try {
      List<Qari> qariList = await apiServices.getQariList();
      setState(() {
        allQariList = qariList;
        filteredQariList = qariList;
      });
    } catch (e) {
      print("Error fetching Qari list: $e");
    }
  }

  void filterQariList(String query) {
    List<Qari> results = [];
    if (query.isEmpty) {
      results = allQariList;
    } else {
      results = allQariList
          .where((qari) => qari.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredQariList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Qari\'s',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: TColors.primary,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 1,
                          spreadRadius: 0.0,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        filterQariList(value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: filteredQariList.isEmpty
                      ? const Center(
                    child: Text('No Qari\'s found'),
                  )
                      : ListView.builder(
                    itemCount: filteredQariList.length,
                    itemBuilder: (context, index) {
                      return QariCustomTile(
                          qari: filteredQariList[index],
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AudioSurahScreen(
                                        qari: filteredQariList[index])));
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
