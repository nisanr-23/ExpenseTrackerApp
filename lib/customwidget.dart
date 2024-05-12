import 'package:flutter/material.dart';

class CustomContainer {
  static Widget coloredContainer({
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: 100, // Fixed width
      height: 100, // Fixed height
      color: color,
      child: child,
    );
  }
}
