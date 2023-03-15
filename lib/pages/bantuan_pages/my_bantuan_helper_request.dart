import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class MyBantuanHelperRequestPage extends StatefulWidget {
  @override
  State<MyBantuanHelperRequestPage> createState() => _MyBantuanHelperRequestPageState();
}

class _MyBantuanHelperRequestPageState extends State<MyBantuanHelperRequestPage> {
  var empty = true;

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

    Widget ExistContent() {
      return Container();
    }

    Widget RenderContent() {
      return empty ? EmptyContent() : ExistContent();
    }

    return Scaffold(
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