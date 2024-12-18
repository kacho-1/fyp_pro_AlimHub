
import 'package:flutter/material.dart';

import '../../CommonFeatures/Customs/CustomColor.dart';

class TisbahScreen extends StatefulWidget {
  const TisbahScreen({super.key});

  @override
  State<TisbahScreen> createState() => _TisbahScreenState();
}

class _TisbahScreenState extends State<TisbahScreen> {
  int _counter = 0;
  int _selectedRange = 100;
  void _incrementCounter() {
    setState(() {
      if (_counter < _selectedRange) {
        _counter++;
      }
    });
  }
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }
  void _changeRange(int newRange) {
    setState(() {
      _selectedRange = newRange;
      _counter = 0; // Reset the counter when range is changed
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasbih',
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: TColors.primary,
      ),
      body: Stack(
        children: [
          // Background image using Container with BoxDecoration
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_tasbih.jpg'), // Background image path
                fit: BoxFit.cover, // Cover entire background
              ),
            ),
          ),
          // Counter buttons and circles
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(), // To push the buttons to the middle
              // Row for Reset button and Range selector button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Range selection circle (left side)
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () => _showRangeSelectionDialog(context),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,

                            )
                        ),
                        child: Center(
                          child: Text(
                            'Range\n$_selectedRange',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Reset circle button (right side)
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: _resetCounter,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                            width: 3,

                          )
                        ),
                        child: const Center(
                          child: Text(
                            'Reset',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30), // Space between range/reset and counter
              // Large counter button at the bottom
              GestureDetector(
                onTap: _incrementCounter,
                child: Container(
                  width: 250, // Increased size of the counter button
                  height: 250, // Increased size of the counter button
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.grey,
                      width: 3,

                    ),

                  ),
                  child: Center(
                    child: Text(
                      '$_counter', // Display the counter value
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 60, // Larger text for counter value
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add space at the bottom
            ],
          ),
        ],
      ),
    );
  }

  // Method to display a dialog for range selection
  void _showRangeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Range"),
          content: SizedBox(
            height: 250, // Increase height to fit larger ranges
            child: ListView(
              children: [
                ListTile(
                  title: const Text("7"),
                  onTap: () {
                    _changeRange(7);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text("33"),
                  onTap: () {
                    _changeRange(33);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text("100"),
                  onTap: () {
                    _changeRange(100);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text("500"),
                  onTap: () {
                    _changeRange(500);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text("1000"), // Added 1000 option
                  onTap: () {
                    _changeRange(1000);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
