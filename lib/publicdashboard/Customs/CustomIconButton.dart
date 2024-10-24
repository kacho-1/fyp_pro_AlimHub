/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageTextButton extends StatelessWidget {
  final String imageSource;
  final String buttonText;
  final VoidCallback onPressed;

  CustomImageTextButton({
    required this.imageSource,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 19),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            imageSource,
            width: 30,
            height: 30,
          ),
          SizedBox(width: 8),
          Text(
            buttonText,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgTextButton extends StatelessWidget {
  final String svgPath;
  final String text;
  final VoidCallback onPressed;

  const SvgTextButton({
    Key? key,
    required this.svgPath,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 70, // Customize the size
            width: 70,
            //color: Colors.blue, // Add color if needed
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

