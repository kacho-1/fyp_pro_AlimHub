import 'package:flutter/material.dart';

class Category {
  final String name;
  final String svgPath;
  final Widget destination;

  Category({
    required this.name,
    required this.svgPath,
    required this.destination,
  });
}