import 'dart:async';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/pages/helper_pages/helper_profile_page.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/view_models/bantuan_order_view_model.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/helper_items/helper_request_item.dart';
import 'package:bantuin/widgets/img_text_btn/img_desc_btn.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class MyBantuanHelperRequestPage extends StatefulWidget {
  @override
  State<MyBantuanHelperRequestPage> createState() => _MyBantuanHelperRequestPageState();

  List<BantuanOrderModel> orders;
  MyBantuanHelperRequestPage(this.orders);
}

class _MyBantuanHelperRequestPageState extends State<MyBantuanHelperRequestPage> {
  late var orderVm = BantuanOrderViewModel(context);

  var loading = false;
  var loadingTitle = 'Accepting . . .';
  void toggleLoading(value, title) {
    this.setState(() {
      loading = value;
      loadingTitle = title;
    });
  }

  void denyOrder(id) async {
    Navigator.pop(context);

    toggleLoading(true, 'Denying . . .');
    var result = await orderVm.denyOrder(orderId: id);
    toggleLoading(false, 'Denying . . .');

    if (result) {
      showGLobalAlert('success', 'Berhasil menolak bantuan', context);
      setPage(context, 'profile');
      Navigator.pushNamed(context, '/main');
      Timer(Duration(milliseconds: 500), () {
        Navigator.pushNamed(context, '/my-bantuan');
      });
    }
  }

  void acceptOrder(id) async {
    Navigator.pop(context);

    toggleLoading(true, 'Accepting . . .');
    var result = await orderVm.acceptOrder(orderId: id);
    toggleLoading(false, 'Accepting . . .');

    if (result) {
      Navigator.pushNamed(context, '/my-bantuan-accept-success');
    }
  }

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
            setPage(context, 'home');
            Navigator.pushNamed(context, '/main');
          },
        ),
      );
    }

    Widget DenyDrawerContent(int id) {
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
                denyOrder(id);
              },
              type: 'danger',
            )
          ],
        ),
      );
    }

    Widget AcceptDrawerContent(int id) {
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
                acceptOrder(id);
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
          children: this.widget.orders.map((order) {
            return HelperRequestItem(
              order: order,
              onAccept: () {
                showDrawer(context, 398, AcceptDrawerContent(order.id));
              },
              onDeny: () {
                showDrawer(context, 398, DenyDrawerContent(order.id));
              },
              onChat: (){},
              onProfile: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperProfilePage(order.helper!, order.id)
                  )
                );
              },
            );
          }).toList()
        ),
      );
    }

    Widget RenderContent() {
      return this.widget.orders.length > 0 ?  ExistContent() : EmptyContent();
    }

    Widget LoadingContent() {
      return Container(
        color: black.withOpacity(0.5),
        child: LoadingCustom(
          title: loadingTitle,
          isWhite: true,
        ),
      );
    }

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
            loading ? LoadingContent() : SizedBox()
          ],
        )
      ),
    );
  }
}