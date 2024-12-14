import 'package:flutter/material.dart';

import '../../CommonFeatures/Customs/CustomAppPortion.dart';
import '../../CommonFeatures/Customs/CustomAppbar.dart';
import '../../CommonFeatures/Customs/CustomContainier.dart';


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
            const Padding(padding: EdgeInsets.all(24),
              child: CAppPortion()
            )


          ],
        ),
      ),
    );
  }
}
