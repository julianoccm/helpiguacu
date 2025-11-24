import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;
  final double? customFont;

  const PageTitle({super.key, required this.text, this.customFont});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: customFont ?? (kIsWeb ? 25  : 20)),
    );
  }
}
