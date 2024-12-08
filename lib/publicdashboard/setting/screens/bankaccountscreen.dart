/*
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class BankAccount extends StatefulWidget {
  const BankAccount({super.key});

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  String cardNumber = '';
  String expireDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCVVFocuseded= false;
  final updateDOBFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expireDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCVVFocuseded,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  onCreditCardWidgetChange: (CreditCardBrand brand) {},
                  animationDuration: Duration(milliseconds: 1000),
              ),
              Expanded(
                  child: SingleChildScrollView(

              child: CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expireDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: onmodelChange,
                  formKey: updateDOBFormKey),))
            ],
          )),
    );

  }
  void onmodelChange(CreditCardModel model){
    cardNumber = model.cardNumber;
    expireDate = model.expiryDate;
    cardHolderName = model.cardHolderName;
    cvvCode = model.cvvCode;
    isCVVFocuseded = model.isCvvFocused;
  }
}
*/
