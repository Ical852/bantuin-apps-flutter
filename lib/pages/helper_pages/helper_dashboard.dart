import 'package:bantuin/pages/helper_pages/helper_bantuan_detail_done.dart';
import 'package:bantuin/pages/helper_pages/helper_bantuan_detail_on_going.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/helper_items/helper_insight.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:bantuin/widgets/main_items/weekly_item.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money_profile.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:bantuin/widgets/toggler/double_text_toggler.dart';
import 'package:flutter/material.dart';

class HelperDashboardPage extends StatefulWidget {
  @override
  State<HelperDashboardPage> createState() => _HelperDashboardPageState();
}

class _HelperDashboardPageState extends State<HelperDashboardPage> {
  var currentToggle = "left";
  void toggleToggler(value) {
    this.setState(() {
      currentToggle = value;
    });
  }

  var leftEmpty = false;
  var rightEmpty = false;

  @override
  Widget build(BuildContext context) {
    Widget HelperBM() {
      return Marginner(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: BantuanMoneyProfile(
          name: 'Shalahuddin Ahmad Aziz',
          phone: '089674839221',
          price: 9200301,
        ),
      );
    }

    Widget HelperInsightContent() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTitleDesc(
                title: 'Insight Helper Kamu',
                desc: 'Insight selama kamu sebagai helper'),
            SizedBox(
              height: 16,
            ),
            HelperInsight(
              money: 15500000,
              totalHelp: 314,
              rate: 4.8,
              onMoney: () {},
              onHelp: () {},
              onRate: () {},
            ),
            SizedBox(
              height: 32,
            )
          ],
        ),
      );
    }

    Widget ContentToggler() {
      return DoubleTextToggler(
        current: currentToggle,
        left: 'Sedang Berjalan',
        right: 'Telah Selesai',
        leftPress: () => toggleToggler('left'),
        rightPress: () => toggleToggler('right'),
      );
    }

    Widget LeftEmpty() {
      return Container(
        margin: EdgeInsets.only(
          top: 32
        ),
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_empty_bantuan.png',
          title: 'Ups, Kosong',
          desc: 'Wah, sepertinya kamu belum pernah membantu customer, cek home untuk mencoba membantu customer',
          width: 270,
          btnTitle: 'Ke Home',
          onPressed: (){
            Navigator.pushNamed(context, "/main");
          },
        ),
      );
    }

    Widget LeftExist() {
      return Container(
        margin: EdgeInsets.only(
          top: 32,
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            WeeklyItem(
              image: 'assets/dummies/dummy10.png',
              title: 'Bersihin Interior Dalem', 
              desc:
                  'Ada kosan di bekasi, butuh bantuan bersihin dalem sampe selesai',
              location: 'Bekasi, Indonesia',
              price: 2125000,
              onPress: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperBantuanDetailOnGoingPage(),
                  )
                );
              },
              isHelper: true,
            ),
            WeeklyItem(
              image: 'assets/dummies/dummy11.png',
              title: 'Bersihin Kolam Renang',
              desc:
                  'Kolam renang gua ijo, kotor, butuh bantuan bersihin, 1,5k lepas',
              location: 'Bogor, Indonesia',
              price: 1500000,
              onPress: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperBantuanDetailOnGoingPage(),
                  )
                );
              },
              isHelper: true,
            ),
            WeeklyItem(
              image: 'assets/dummies/dummy12.png',
              title: 'Cuci Motor Gue',
              desc: 'Motor lama mo di repain, tapi butuh bantu buat di cuci',
              location: 'Jakarta, Indonesia',
              price: 1725000,
              onPress: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperBantuanDetailOnGoingPage(),
                  )
                );
              },
              isHelper: true,
            ),
          ],
        ),
      );
    }

    Widget LeftContentRender() {
      return leftEmpty ? LeftEmpty() : LeftExist();
    }

    Widget RightEmpty() {
      return Container(
        margin: EdgeInsets.only(
          top: 32
        ),
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_empty_bantuan.png',
          title: 'Ups, Kosong',
          desc: 'Wah, sepertinya kamu belum pernah menyelesaikan bantuan dari customer, cek home untuk mencoba membantu customer',
          width: 280,
          btnTitle: 'Ke Home',
          onPressed: (){
            Navigator.pushNamed(context, "/main");
          },
        ),
      );
    }

    Widget RightExist() {
      return Container(
        margin: EdgeInsets.only(
          top: 32,
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            WeeklyItem(
              image: 'assets/dummies/dummy11.png',
              title: 'Bersihin Kolam Renang',
              desc:
                  'Kolam renang gua ijo, kotor, butuh bantuan bersihin, 1,5k lepas',
              location: 'Bogor, Indonesia',
              price: 1500000,
              onPress: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperBantuanDetailDonePage(),
                  )
                );
              },
              isHelper: true,
            ),
            WeeklyItem(
              image: 'assets/dummies/dummy12.png',
              title: 'Cuci Motor Gue',
              desc: 'Motor lama mo di repain, tapi butuh bantu buat di cuci',
              location: 'Jakarta, Indonesia',
              price: 1725000,
              onPress: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperBantuanDetailDonePage(),
                  )
                );
              },
              isHelper: true,
            ),
            WeeklyItem(
              image: 'assets/dummies/dummy10.png',
              title: 'Bersihin Interior Dalem', 
              desc:
                  'Ada kosan di bekasi, butuh bantuan bersihin dalem sampe selesai',
              location: 'Bekasi, Indonesia',
              price: 2125000,
              onPress: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperBantuanDetailDonePage(),
                  )
                );
              },
              isHelper: true,
            ),
          ],
        ),
      );
    }

    Widget RightContentRender() {
      return rightEmpty ? RightEmpty() : RightExist();
    }

    Widget ToggledContentRender() {
      return currentToggle == 'left' ? LeftContentRender() : RightContentRender();
    }

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(
              title: 'Dashboard Helper',
              onBack: (){
                Navigator.pop(context);
              },
              rightContent: ImageCustom(
                width: 17,
                height: 20,
                image: AssetImage('assets/icons/ic_notif_chat.png'),
              ),
              onRightPress: () {
                Navigator.pushNamed(context, '/notifications');
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 12
                ),
                children: [
                  HelperBM(),
                  SizedBox(height: 32,),
                  Line(),
                  SizedBox(height: 24,),
                  HelperInsightContent(),
                  ContentToggler(),
                  ToggledContentRender(),
                  SizedBox(height: 120,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}