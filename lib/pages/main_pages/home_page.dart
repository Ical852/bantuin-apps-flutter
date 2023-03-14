import 'package:bantuin/pages/detail_pages/bantuan_detail_pages.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money.dart';
import 'package:bantuin/widgets/buttons/mini_icon_button_custom.dart';
import 'package:bantuin/widgets/main_items/expensive_item.dart';
import 'package:bantuin/widgets/main_items/new_item.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

  Function() openDrawer;
  HomePage(this.openDrawer);
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    Widget HeaderBackground() {
      return Container(
        height: 125 + safeAreaPadding(context),
        decoration: BoxDecoration(
          color: green1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12)
          )
        ),
      );
    }

    Widget HeaderContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 32 + safeAreaPadding(context),
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MiniIconButtonCustom(
                      onPressed: (){
                        this.widget.openDrawer();
                      },
                      icons: 'assets/icons/ic_bar.png',
                      width: 16,
                      height: 14,
                    ),
                    Container(width: 34,)
                  ],
                ),
                Text(
                  'Cari Bantuan',
                  style: regularWhiteSemibold
                ),
                Row(
                  children: [
                    MiniIconButtonCustom(
                      onPressed: (){
                        Navigator.pushNamed(context, '/bantuan-search');
                      },
                      icons: 'assets/icons/ic_search_home.png',
                      width: 18,
                      height: 18,
                    ),
                    SizedBox(width: 8,),
                    MiniIconButtonCustom(
                      onPressed: (){
                        Navigator.pushNamed(context, '/notifications');
                      },
                      icons: 'assets/icons/ic_notif.png',
                      width: 16,
                      height: 19,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 24,),
            BantuanMoney(
              money: 9200301,
              onPress: (){
                Navigator.pushNamed(context, '/top-up');
              },
            )
          ],
        ),
      );
    }

    Widget HomeTitleDesc(title, desc) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24
        ),
        child: MainTitleDesc(
          title: title,
          desc: desc,
        ),
      );
    }

    Widget ExpensiveSection() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTitleDesc('Bantuan Temahal', 'Temukan bantuan termahal dan dapatkan uangmu'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 24,),
                  ExpensiveItem(
                    image: 'assets/dummies/dummy1.png',
                    title: 'Keamanan Camping',
                    category: 'Game',
                    location: 'Bekasi, Indonesia',
                    price: 6000000,
                    onPress: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => BantuanDetailPage()
                        )
                      );
                    },
                  ),
                  ExpensiveItem(
                    image: 'assets/dummies/dummy2.png',
                    title: 'Bantu Rapihin Rumah',
                    category: 'Kebersihan',
                    location: 'Bogor, Indonesia',
                    price: 1250000,
                    onPress: (){},
                  ),
                  ExpensiveItem(
                    image: 'assets/dummies/dummy3.png',
                    title: 'Bantu Desain Web',
                    category: 'Gawe',
                    location: 'Tangerang, Indonesia',
                    price: 1250000,
                    onPress: (){},
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget NewSection() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTitleDesc('Bantuan Terbaru', 'Temukan bantuan terbaru, customer butuh kamu!'),
            Container(
              margin: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewItem(
                    image: 'assets/dummies/dummy4.png',
                    title: 'Bantu Push Rank',
                    desc: 'Bantu gua push rank sampe mytical glory',
                    location: 'Bekasi, Indonesia',
                    price: 370000,
                    onPress: (){},
                  ),
                  NewItem(
                    image: 'assets/dummies/dummy5.png',
                    title: 'Bantu Steam Mobil',
                    desc: 'Bantu cuci mobil di steam gua, 20k / mobil',
                    location: 'Bekasi, Indonesia',
                    price: 580000,
                    onPress: (){},
                  ),
                  NewItem(
                    image: 'assets/dummies/dummy6.png',
                    title: 'Bantu Cor Atap',
                    desc: 'bantu cor atap rumah gua, beres 300k sung gas',
                    location: 'Bekasi, Indonesia',
                    price: 300000,
                    onPress: (){},
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget MainContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 182 + safeAreaPadding(context)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpensiveSection(),
            NewSection(),
            SizedBox(height: 150,)
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Stack(
        children: [
          HeaderBackground(),
          HeaderContent(),
          MainContent(),
        ],
      ),
    );
  }
}