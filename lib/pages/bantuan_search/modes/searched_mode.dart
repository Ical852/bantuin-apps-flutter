import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/pages/detail_pages/bantuan_detail_pages.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/main_items/grid_item.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:flutter/material.dart';

class SearchedMode extends StatelessWidget {

  List<BantuanModel> bantuans;
  SearchedMode({
    required this.bantuans
  });
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
          top: 24
        ),
        children: [
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
                top: 16,
                bottom: 32
              ),
              crossAxisCount: 2,
              childAspectRatio: 157/205,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: bantuans.map((bantuan) {
                return GridItem(onPress: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => BantuanDetailPage(bantuan)
                    )
                  );
                }, bantuan: bantuan);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}