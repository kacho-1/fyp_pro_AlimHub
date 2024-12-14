import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../CommonFeatures/Customs/CustomColor.dart';

class BankAccount extends StatefulWidget {
  const BankAccount({super.key});

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  final _storage = const FlutterSecureStorage();
  String cardNumber = '';
  String expireDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCVVFocused = false;
  final updateDOBFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadStoredCardDetails();
  }

  /// Load stored card details and populate fields
  Future<void> _loadStoredCardDetails() async {
    cardNumber = await _storage.read(key: 'cardNumber') ?? '';
    expireDate = await _storage.read(key: 'expireDate') ?? '';
    cardHolderName = await _storage.read(key: 'cardHolderName') ?? '';
    // CVV is not stored for security reasons; leave it blank.
    setState(() {});
  }

  /// Save card details securely
  Future<void> _saveCardDetails() async {
    await _storage.write(key: 'cardNumber', value: cardNumber);
    await _storage.write(key: 'expireDate', value: expireDate);
    await _storage.write(key: 'cardHolderName', value: cardHolderName);
  }

  /// Update card details dynamically
  void onModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expireDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCVVFocused = model.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expireDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCVVFocused,
              height: 200,
              width: MediaQuery.of(context).size.width,
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
              animationDuration: const Duration(milliseconds: 1000),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expireDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: onModelChange,
                  formKey: updateDOBFormKey, themeColor: Colors.white54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (updateDOBFormKey.currentState!.validate()) {
                    await _saveCardDetails();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Card details saved securely!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: TColors.primary,
                  minimumSize: const Size(200, 50),
                ),
                child: const Text('Save Card Details',style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
