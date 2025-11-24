import 'package:flutter/material.dart';
import 'package:frontend/constants/colors.dart';

class Subtitle extends StatelessWidget {
  final String text;

  const Subtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: NutricanColors.font),
    );
  }
}