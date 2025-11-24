import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String goGackPage;

  const Header({super.key, required this.goGackPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kIsWeb ? 40 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         IconButton(
           alignment: Alignment.center,
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName(goGackPage));
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 20),
                ),

        ],
      ),
    );
  }
}
