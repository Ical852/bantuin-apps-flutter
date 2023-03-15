import 'package:bantuin/pages/bantuan_pages/my_bantuan_detail.dart';
import 'package:bantuin/pages/bantuan_pages/my_bantuan_detail_accepted.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/main_items/weekly_item.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class MyBantuanPage extends StatefulWidget {
  @override
  State<MyBantuanPage> createState() => _MyBantuanPageState();
}

class _MyBantuanPageState extends State<MyBantuanPage> {
  var empty = false;

  @override
  Widget build(BuildContext context) {
    Widget SearchBar() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14
        ),
        height: 40,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(0, 2)
            )
          ],
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Flexible(
              child: Focus(
                child: TextFormField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search Text',
                    hintStyle: regularGrayRegular
                  ),
                  style: regularBlackRegular
                ),
              ),
            ),
            SizedBox(width: 14,),
            ImageCustom(
              height: 20,
              width: 20,
              image: AssetImage('assets/icons/ic_search_green.png'),
            )
          ],
        ),
      );
    }

    Widget EmptyContent() {
      return Container(
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_empty_bantuan.png',
          title: 'Ups, Kosong',
          desc: 'Wah, sepertinya kamu belum pernah publikasikan permintaan bantuan kamu, silakan buat bantuan',
          width: 260,
          btnTitle: 'Ke Home',
          onPressed: (){
            Navigator.pushNamed(context, '/main');
          },
        ),
      );
    }

    Widget ExistContent() {
      return Container(
        child: Column(
          children: [
            SizedBox(height: 24,),
            WeeklyItem(
              image: 'assets/dummies/dummy10.png',
              title: 'Bersihin Interior Dalem',
              desc: 'Ada kosan di bekasi, butuh bantuan bersihin dalem sampe selesai',
              location: 'Bekasi, Indonesia',
              price: 2125000,
              onPress: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => MyBantuanDetailPage()
                  )
                );
              },
              isMine: true,
            ),
            WeeklyItem(
              image: 'assets/dummies/dummy11.png',
              title: 'Bersihin Kolam Renang',
              desc: 'Kolam renang gua ijo, kotor, butuh bantuan bersihin, 1,5k lepas',
              location: 'Bogor, Indonesia',
              price: 1500000,
              onPress: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => MyBantuanDetailAcceptedPage()
                  )
                );
              },
              isMine: true,
            ),
            WeeklyItem(
              image: 'assets/dummies/dummy12.png',
              title: 'Cuci Motor Gue',
              desc: 'Motor lama mo di repain, tapi butuh bantu buat di cuci',
              location: 'Jakarta, Indonesia',
              price: 1725000,
              onPress: (){},
              isMine: true,
            ),
          ],
        ),
      );
    }

    Widget RenderContent() {
      return empty ? EmptyContent() : ExistContent();
    }

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(
              title: 'Your Bantuin Request',
              onBack: (){
                Navigator.pop(context);
              },
              rightContent: ImageCustom(
                width: 17,
                height: 20,
                image: AssetImage('assets/icons/ic_notif_chat.png'),
              ),
              onRightPress: (){
                Navigator.pushNamed(context, '/notifications');
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                ),
                children: [
                  SearchBar(),
                  SizedBox(height: 24,),
                  MainTitleDesc(
                    title: 'Request Bantuan Kamu',
                    desc: 'Manage permintaan bantuan kamu disini',
                  ),
                  RenderContent(),
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