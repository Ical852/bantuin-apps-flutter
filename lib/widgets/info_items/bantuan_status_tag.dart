import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:flutter/material.dart';

class BantuanStatusTag extends StatelessWidget {
  String status;
  BantuanStatusTag({
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2
      ),
      decoration: BoxDecoration(
        color: status == 'process' ? green1 : blue1,
        borderRadius: BorderRadius.circular(6)
      ),
      child: Text(
        status == 'process' ? 'On Going' : 'Done',
        style: regularWhiteSemibold,
      ),
    );
  }
}