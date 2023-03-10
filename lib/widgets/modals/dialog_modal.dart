import 'package:bantuin/shared/constatns.dart';
import 'package:flutter/material.dart';

class DialogModal extends StatelessWidget {

  List<Widget> children;
  DialogModal({
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black.withOpacity(0.5),
      width: double.infinity,
      height: double.infinity,
      child: SimpleDialog(
        children: children
      ),
    );
  }
}