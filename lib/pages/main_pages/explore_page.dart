import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/main_items/special_item.dart';
import 'package:bantuin/widgets/main_items/weekly_item.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {

    Widget HeaderBackground() {
      return Container(
        color: green1,
        height: 120 + safeAreaPadding(context),
      );
    }

    Widget SearchBar() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: 16
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12
          ),
          height: 40,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/bantuan-search');
            },
            child: Row(
              children: [
                ImageCustom(
                  height: 20,
                  width: 20,
                  image: AssetImage('assets/icons/ic_search_green.png'),
                  margin: EdgeInsets.only(
                    right: 12
                  ),
                ),
                Text(
                  'Explore campaigns',
                  style: regularGrayRegular
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget NotifButton() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: white
        ),
        width: 40,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent.withOpacity(0.1),
            padding: EdgeInsets.all(0)
          ),
          onPressed: (){
            Navigator.pushNamed(context, '/notifications');
          },
          child: Center(
            child: ImageCustom(
              height: 17,
              width: 15,
              image: AssetImage('assets/icons/ic_notif_green.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget HeaderContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 24 + safeAreaPadding(context),
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            Row(
              children: [
                SearchBar(),
                NotifButton()
              ],
            ),
            SizedBox(height: 14,),
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

    Widget ExploreTitleDesc(title, desc) {
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
    
    Widget SpecialSection() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExploreTitleDesc('Spesial Bersih - Bersih', 'Khusus untuk kamu yang hobi bersih - bersih'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 24,),
                  SpecialItem(
                    image: 'assets/dummies/dummy7.png',
                    title: 'Bersihin Kosan Putri',
                    category: 'Clean',
                    location: 'Jakarta, Indonesia',
                    price: 1800000,
                    onPress: (){},
                  ),
                  SpecialItem(
                    image: 'assets/dummies/dummy8.png',
                    title: 'Sapu Halaman Komplek',
                    category: 'Clean',
                    location: 'Bogor, Indonesia',
                    price: 2500000,
                    onPress: (){},
                  ),
                  SpecialItem(
                    image: 'assets/dummies/dummy9.png',
                    title: 'Bersihin Kolam Renang',
                    category: 'Clean',
                    location: 'Bandung, Indonesia',
                    price: 1750000,
                    onPress: (){},
                  ),
                  SizedBox(width: 8,),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget WeeklySection() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExploreTitleDesc('Bantuan 1 Minggu Terakhir', 'Temukan bantuan terbaru, customer butuh kamu!'),
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 24,
                right: 24
              ),
              child: Column(
                children: [
                  WeeklyItem(
                    image: 'assets/dummies/dummy10.png',
                    title: 'Bersihin Interior Dalem',
                    desc: 'Ada kosan di bekasi, butuh bantuan bersihin dalem sampe selesai',
                    location: 'Bekasi, Indonesia',
                    price: 2125000,
                    onPress: (){},
                  ),
                  WeeklyItem(
                    image: 'assets/dummies/dummy11.png',
                    title: 'Bersihin Kolam Renang',
                    desc: 'Kolam renang gua ijo, kotor, butuh bantuan bersihin, 1,5k lepas',
                    location: 'Bogor, Indonesia',
                    price: 1500000,
                    onPress: (){},
                  ),
                  WeeklyItem(
                    image: 'assets/dummies/dummy12.png',
                    title: 'Cuci Motor Gue',
                    desc: 'Motor lama mo di repain, tapi butuh bantu buat di cuci',
                    location: 'Jakarta, Indonesia',
                    price: 1725000,
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
            SpecialSection(),
            WeeklySection(),
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
          MainContent()
        ],
      ),
    );
  }
}