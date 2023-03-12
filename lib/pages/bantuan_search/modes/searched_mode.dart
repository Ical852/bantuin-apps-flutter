import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/main_items/grid_item.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:flutter/material.dart';

class SearchedMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24,),
          Marginner(
            margin: EdgeInsets.symmetric(
              horizontal: 24
            ),
            child: Text(
              'Pencarian paling relevan',
              style: regularBlackSemibold,
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16
              ),
              crossAxisCount: 2,
              childAspectRatio: 157/205,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                GridItem(),
                GridItem(),
                GridItem(),
                GridItem(),
                GridItem(),
                GridItem(),
              ],
            ),
          )
        ],
      ),
    );
  }
}