import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/main_items/grid_item.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:flutter/material.dart';

class SearchedMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
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
              children: [
                GridItem(
                  image: 'assets/dummies/dummy13.png',
                  title: 'Mengajar Kursus Flutter Untuk Anak SD',
                  location: 'Jakarta, Indonesia',
                  price: 257000,
                  onPress: (){},
                ),
                GridItem(
                  image: 'assets/dummies/dummy14.png',
                  title: 'Mengajar Desain Untuk Anak SMA',
                  location: 'Tangerang, Indonesia',
                  price: 357000,
                  onPress: (){},
                ),
                GridItem(
                  image: 'assets/dummies/dummy15.png',
                  title: 'Menjadi Tour Guide Turis Di Bekasi',
                  location: 'Bekasi, Indonesia',
                  price: 157000,
                  onPress: (){},
                ),
                GridItem(
                  image: 'assets/dummies/dummy16.png',
                  title: 'Menjadi Guru Sejarah di DGGCourse',
                  location: 'Bogor, Indonesia',
                  price: 427000,
                  onPress: (){},
                ),
                GridItem(
                  image: 'assets/dummies/dummy17.png',
                  title: 'Bantu Saya Mengajar Via Zoom',
                  location: 'Depok, Indonesia',
                  price: 355000,
                  onPress: (){},
                ),
                GridItem(
                  image: 'assets/dummies/dummy18.png',
                  title: 'Mengajarkan Homeless Bahasa Inggris',
                  location: 'Tangerang, Indonesia',
                  price: 325000,
                  onPress: (){},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}