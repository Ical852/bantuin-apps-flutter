import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/pages/helper_pages/helper_profile_page.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/helper_items/helper_request_item.dart';
import 'package:bantuin/widgets/img_text_btn/img_desc_btn.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class MyBantuanHelperRequestPage extends StatefulWidget {
  @override
  State<MyBantuanHelperRequestPage> createState() => _MyBantuanHelperRequestPageState();
}

class _MyBantuanHelperRequestPageState extends State<MyBantuanHelperRequestPage> {
  var empty = false;

  @override
  Widget build(BuildContext context) {
    Widget EmptyContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 64
        ),
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_empty_bantuan.png',
          title: 'Ups, Kosong',
          desc: 'Wah, sepertinya belum ada yang ingin membantu kamu',
          width: 260,
          btnTitle: 'Ke Home',
          onPressed: (){
            Navigator.pushNamed(context, '/main');
          },
        ),
      );
    }

    Widget DenyDrawerContent() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(
              height: 24,
            ),
            ImgDescBtn(
              image: 'assets/illustrations/il_question.png',
              title: 'Tolak Request',
              desc: 'Kamu yakin untuk menolak request dari Helper James Curt ?',
              onPress: () {
                showGLobalAlert('success', 'Berhasil menolak bantuan', context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              type: 'danger',
            )
          ],
        ),
      );
    }

    Widget AcceptDrawerContent() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(
              height: 24,
            ),
            ImgDescBtn(
              image: 'assets/illustrations/il_accept.png',
              title: 'Terima Request',
              desc: 'Kamu yakin untuk menerima request dari Helper James Curt ?',
              onPress: () {
                Navigator.pushNamed(context, '/my-bantuan-accept-success');
              },
            )
          ],
        ),
      );
    }

    Widget ExistContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 24
        ),
        child: Column(
          children: [
            HelperRequestItem(
              image: 'assets/dummies/user1.png',
              name: 'James Curt',
              desc: 'Helper',
              onAccept: () {
                showDrawer(context, 398, AcceptDrawerContent());
              },
              onDeny: () {
                showDrawer(context, 398, DenyDrawerContent());
              },
              onChat: (){},
              onProfile: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperProfilePage()
                  )
                );
              },
            ),
            HelperRequestItem(
              image: 'assets/dummies/user2.png',
              name: 'Rosalie Emily',
              desc: 'Helper',
              onAccept: () {
                showDrawer(context, 398, AcceptDrawerContent());
              },
              onDeny: () {
                showDrawer(context, 398, DenyDrawerContent());
              },
              onChat: () {},
              onProfile: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperProfilePage()
                  )
                );
              },
            ),
            HelperRequestItem(
              image: 'assets/dummies/user3.png',
              name: 'Anna Joeson',
              desc: 'Helper',
              onAccept: () {
                showDrawer(context, 398, AcceptDrawerContent());
              },
              onDeny: () {
                showDrawer(context, 398, DenyDrawerContent());
              },
              onChat: () {},
              onProfile: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperProfilePage()
                  )
                );
              },
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
              title: 'Helper Request',
              onBack: (){
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24
                ),
                children: [
                  MainTitleDesc(
                    title: 'Request Helper',
                    desc: 'Ada helper  yang ingin bantu kamu',
                  ),
                  RenderContent()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}