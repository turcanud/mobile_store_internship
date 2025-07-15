import 'package:flutter/material.dart';

class TitleCustom extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  const TitleCustom({
    super.key,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    this.color = const Color(0xFF000000),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  const SectionTitle({
    super.key,
    required this.title,
    this.color = const Color(0xFF000000),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}
