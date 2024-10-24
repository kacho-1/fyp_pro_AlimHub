import 'package:flutter/material.dart';

class CustomCurveEdge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    
    path.lineTo(0, size.height);

    final leftControlPoint = Offset(size.width * 0.05, size.height * 1.05); 
    final leftEndPoint = Offset(size.width * 0.1, size.height * 0.95); 
    path.quadraticBezierTo(leftControlPoint.dx, leftControlPoint.dy, leftEndPoint.dx, leftEndPoint.dy);

    
    path.lineTo(size.width * 0.9, size.height * 0.95); 

    
    final rightControlPoint = Offset(size.width * 0.95, size.height * 1.05); 
    final rightEndPoint = Offset(size.width, size.height); 
    path.quadraticBezierTo(rightControlPoint.dx, rightControlPoint.dy, rightEndPoint.dx, rightEndPoint.dy);

    
    path.lineTo(size.width, 0);

    
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; 
  }
}
