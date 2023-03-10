import 'package:bantuin/shared/constatns.dart';
import 'package:flutter/material.dart';

class MiniButtonIconCustom extends StatelessWidget {

  String title;
  Function() onPress;
  IconData icon;

  MiniButtonIconCustom({
    required this.title,
    required this.onPress,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: green1
      ),
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
        ),
        onPressed: onPress,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 8,),
            Text(
              title,
              style: poppinsText.copyWith(
                fontSize: 14,
                fontWeight: medium
              ),
            ),
          ],
        ),
      ),
    );
  }
}