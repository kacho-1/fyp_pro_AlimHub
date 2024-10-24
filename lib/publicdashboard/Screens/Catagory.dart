import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomAppPortion.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomAppbar.dart';
import 'package:fyp_pro/publicdashboard/Customs/CustomContainier.dart';
import 'package:fyp_pro/publicdashboard/Customs/customSettingsection.dart';

import '../Customs/CustomSettingboarding.dart';

class CatagoryScreen extends StatelessWidget {
  const CatagoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child:Column(
                  children: [

                    CAppBar(

                      title: Center(
                        child: Text('Category',
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),),
                      ),

                    ),

                  ],
                )
            ),
            Padding(padding: EdgeInsets.all(24),
              child: CAppPortion()
            )


          ],
        ),
      ),
    );
  }
}
