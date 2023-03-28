import 'dart:convert';

import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/pages/bantuan_pages/my_bantuan_detail.dart';
import 'package:bantuin/pages/bantuan_pages/my_bantuan_detail_accepted.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/bantuan_view_model.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:bantuin/widgets/main_items/weekly_item.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class MyBantuanPage extends StatefulWidget {
  @override
  State<MyBantuanPage> createState() => _MyBantuanPageState();
}

class _MyBantuanPageState extends State<MyBantuanPage> {
  late var bantuanVm = BantuanViewModel(context);

  List<BantuanModel> bantuanData = [];
  List<BantuanModel> filterData = [];
  bool loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void getMyBantuanData() async {
    toggleLoading(true);
    var result = await bantuanVm.getBantuanByUserId();
    toggleLoading(false);
    if (result) {
      this.setState(() {
        bantuanData = bantuanVm.getMyBantuan();
        filterData = bantuanVm.getMyBantuan();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMyBantuanData();
  }

  void onSearch(value) {
    var newData = [...bantuanData];
    var filter = newData.where((bantuan) => 
      bantuan.title.toLowerCase().contains(value.toString().toLowerCase()) ||
      bantuan.desc.toLowerCase().contains(value.toString().toLowerCase()) ||
      bantuan.location.toLowerCase().contains(value.toString().toLowerCase()) ||
      bantuan.price.toString().contains(value.toString())
    ).toList();
    this.setState(() {
      filterData = filter;
    });
  }

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
                  style: regularBlackRegular,
                  onChanged: (value) {
                    onSearch(value);
                  },
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
            Column(
              children: filterData.map((bantuan) {
                return WeeklyItem(
                  bantuan: bantuan,
                  onPress: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) {
                          if (bantuan.status == 'process' || bantuan.status == 'done') {
                            return MyBantuanDetailAcceptedPage(bantuan);
                          }
                          return MyBantuanDetailPage(bantuan);
                        } 
                      )
                    );
                  },
                  isMine: true,
                );
              }).toList(),
            )
          ],
        ),
      );
    }

    Widget LoadingContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 200
        ),
        child: LoadingCustom(title: 'Getting Bantuan Data . . .',)
      );
    }

    Widget RenderContent() {
      return loading ? LoadingContent() : bantuanData.length > 0 ? ExistContent() : EmptyContent();
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