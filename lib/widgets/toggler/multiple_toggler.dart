import 'package:bantuin/widgets/toggler/multi_toggle_item.dart';
import 'package:flutter/material.dart';

class MultipleToggler extends StatelessWidget {

  List<String> toggles;
  String current;
  ValueChanged<String> onPress;

  MultipleToggler({
    required this.toggles,
    required this.current,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: toggles.map((title) {
            return MultiToggleItem(
              title: title,
              onPress: () {
                onPress(title);
              },
              active: title == current,
            );
          }).toList(),
        ),
      ),
    );
  }
}