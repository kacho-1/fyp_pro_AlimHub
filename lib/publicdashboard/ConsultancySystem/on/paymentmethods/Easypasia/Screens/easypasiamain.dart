import 'package:flutter/material.dart';

class EasyPaisaPaymentPage extends StatefulWidget {
  const EasyPaisaPaymentPage({Key? key}) : super(key: key);

  @override
  _EasyPaisaPaymentPageState createState() => _EasyPaisaPaymentPageState();
}

class _EasyPaisaPaymentPageState extends State<EasyPaisaPaymentPage> {
  final _mobileNumberController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EasyPaisa Payment',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your EasyPaisa details:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _mobileNumberController,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _pinController,
              decoration: const InputDecoration(
                labelText: 'PIN',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // EasyPaisa payment processing logic can be added here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Payment Successful!")),
                );
              },
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
