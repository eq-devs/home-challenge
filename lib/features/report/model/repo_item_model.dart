import 'package:flutter/material.dart';

class ReportItem {
  final String title;
  final String body;
  final Color? color;
  final Color? cColor;
  final IconData iconData;

  ReportItem(
      {required this.title,
      required this.body,
      required this.color,
      required this.cColor,
      required this.iconData});
}
