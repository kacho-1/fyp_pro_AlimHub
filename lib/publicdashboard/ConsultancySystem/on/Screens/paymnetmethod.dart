import 'package:flutter/material.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/paymentmethods/Card/Screens/cardmainscreen.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/paymentmethods/Easypasia/Screens/easypasiamain.dart';
import 'package:fyp_pro/publicdashboard/ConsultancySystem/on/paymentmethods/Jazzcash/Screens/Jazzcashmain.dart';

import '../../../../CommonFeatures/Customs/CustomColor.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  int type =1;
  void handleRadio(Object? e) => setState((){
    type = e as int;
  });
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,

        ),),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(child: Padding(
          padding:EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              width: size.width,
              height: 55,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                border: type == 1
                        ? Border.all(width: 1,color: TColors.primary)
                        : Border.all(width: 0.9, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,

              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: 1,
                              groupValue: type,
                              onChanged: handleRadio,
                            activeColor: TColors.primary,
                          ),
                          Text('Card Pay',
                          style: type == 1
                                 ? TextStyle(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w500,
                                    color: Colors.black,
                          )
                                  : TextStyle(
                                     fontWeight: FontWeight.w500,
                                     fontSize: 15,
                                     color: Colors.grey,

                          )
                          ),


                        ],
                      ),
                      Image.asset('assets/images/payments/visa.jpg',
                        width: 89,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),

                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: size.width,
              height: 55,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                border: type == 2
                    ? Border.all(width: 1,color: TColors.primary)
                    : Border.all(width: 0.3, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,

              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: type,
                            onChanged: handleRadio,
                            activeColor: TColors.primary,
                          ),
                          Text('Easypaisa ',
                              style: type == 2
                                  ? TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )
                                  : TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey,

                              )
                          ),


                        ],
                      ),
                      Image.asset('assets/images/payments/Easypaisa.jpg',
                        width: 89,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),

                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: size.width,
              height: 55,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                border: type == 3
                    ? Border.all(width: 1,color: TColors.primary)
                    : Border.all(width: 0.3, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,

              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: type,
                            onChanged: handleRadio,
                            activeColor: TColors.primary,
                          ),
                          Text('Jazz Cash',
                              style: type == 3
                                  ? TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )
                                  : TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey,

                              )
                          ),


                        ],
                      ),
                      Image.asset('assets/images/payments/Jazzcash.jpg',
                        width: 89,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),

                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sub-Total',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),),
                Text('\RS: 1000',style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),)

              ],
            ),
            SizedBox(height: 40,),
            Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(

                    onPressed: (){
                      if (type == 1) {
                        // Navigate to Card Pay screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CardPaymentPage()),
                        );
                      } else if (type == 2) {
                        // Navigate to Easypaisa screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EasyPaisaPaymentPage()),
                        );
                      } else if (type == 3) {
                        // Navigate to JazzCash screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JazzCashPaymentPage()),
                        );
                      }

                    } ,
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: TColors.primary,
                      minimumSize: Size (200,50),

                    ),
                    child: Text('Proceed to Pay',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),))
            ),
          ],
        ),
      ),),
      ),
    );
  }
}
