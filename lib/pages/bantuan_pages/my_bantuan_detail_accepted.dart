import 'dart:async';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/pages/bantuan_pages/my_bantuan_helper_request.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/bantuan_order_view_model.dart';
import 'package:bantuin/widgets/buttons/detail_button_custom.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/cancel_item.dart';
import 'package:bantuin/widgets/chat_items/chat_btn.dart';
import 'package:bantuin/widgets/detail_page_items/price_start_item.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_desc_btn.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money_profile.dart';
import 'package:bantuin/widgets/money_contents/cash_on_delivery.dart';
import 'package:bantuin/widgets/money_contents/midtrans_pay.dart';
import 'package:bantuin/widgets/owner_item.dart';
import 'package:bantuin/widgets/rate_items/rate_control.dart';
import 'package:bantuin/widgets/title_descs/detail_title_desc.dart';
import 'package:flutter/material.dart';

class MyBantuanDetailAcceptedPage extends StatefulWidget {
  @override
  State<MyBantuanDetailAcceptedPage> createState() => _MyBantuanDetailAcceptedPageState();

  BantuanModel bantuan;
  MyBantuanDetailAcceptedPage(this.bantuan);
}

class _MyBantuanDetailAcceptedPageState extends State<MyBantuanDetailAcceptedPage> {
  BantuanOrderModel? order = null;
  late var boVm = BantuanOrderViewModel(context);
  void getOrderDetailData() async {
    String status = this.widget.bantuan.status == 'done' ? 'done' : 'process';
    var result = await boVm.getDetailOrderByBantuanId(bantuanId: this.widget.bantuan.id, status: status);

    if (result != null) {
      this.setState(() {
        order = result;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getOrderDetailData();
  }

  var cancels = [
    'Helper Kurang Ramah', 'Berubah Pikiran', 'Waktu Lewat', 'Kurang Jelas', 'Penipuan',
    'Diluar Perkiraan', 'Kurang Uang', 'Tidak Sesuai', 'Helper Cabul'
  ];
  var selected = [];
  TextEditingController reasonController = TextEditingController(text: "");
  var currentReason = "";

  var rating = 0;
  void setRate(int rate, setState) {
    this.setState(() {
      rating = rate;
    });
    setState((){
      rating = rate;
    });
  }

  void selectReason(reason, Function(void Function()) setState) {
    if (selected.contains(reason)) {
      this.setState(() {
        selected.remove(reason);
      });
      setState(() {
        selected.remove(reason);
      });
    } else {
      this.setState(() {
        selected.add(reason);
      });
      setState(() {
        selected.add(reason);
      });
    }
  }

  bool isContain(reason) {
    return selected.contains(reason);
  }

  void onChange(reason, setState) {
    this.setState(() {
      currentReason = reason;
    });
    setState((){
      currentReason = reason;
    });
  }

  var loading = false;
  var loadingTitle = 'Completing Order . . .';
  void toggleLoading(value, title) {
    this.setState(() {
      loading = value;
      loadingTitle = title;
    });
  }

  void onCancel() async {
    Navigator.pop(context);
    
    toggleLoading(true, 'Cancelling Order . . .');
    var result = await boVm.cancelOrder(
      orderId: order!.id,
      reason: '${selected.join(', ')}, $currentReason'
    );
    toggleLoading(false, 'Cancelling Order . . .');

    if (result) {
      setPage(context, 'profile');
      Navigator.pushNamed(context, '/main');
      Timer(Duration(milliseconds: 500), () {
        Navigator.pushNamed(context, '/my-bantuan');
      });
    }
  }

  void onComplete() async {
    Navigator.pop(context);

    toggleLoading(true, 'Completing Order . . .');
    var result = await boVm.completeOrder(orderId: order!.id);
    toggleLoading(false, 'Completing Order . . .');

    if (result) {
      Navigator.pushNamed(context, "/my-bantuan-done");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget HeaderContent() {
      return MainHeader(
        title: 'Detail Bantuin',
        onBack: (){
          Navigator.pop(context);
        },
      );
    }

    Widget CODPayType() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: 32
        ),
        child: CashOnDelivery(
          price: order!.bantuan!.price,
          detail: true,
        ),
      );
    }

    Widget MidtransPayType() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          bottom: 32
        ),
        child: MidtransPay(
          detail: true,
          total: order!.bantuan!.price,
        ),
      );
    }

    Widget BMoneyPayType() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: 32
        ),
        child: BantuanMoneyProfile(
          name: order!.bantuan!.user!.fullName,
          phone: order!.bantuan!.user!.phoneNumber,
          price: 0,
          noMain: true,
          plus: order!.bantuan!.price,
          title: 'Helper akan mendapatkan',
        ),
      );
    }

    Widget RenderPayType() {
      return order!.bantuan!.payType == 'bmoney' ? BMoneyPayType()
      : order!.bantuan!.payType == 'midtrans' ? MidtransPayType()
      : CODPayType();
    }

    Widget ImageAndTitle() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCustom(
            height: 227,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 24
            ),
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(12),
            network: true,
            nwUrl: order!.bantuan!.image,
          ),
          SizedBox(height: 24,),
          Marginner(
            margin: EdgeInsets.symmetric(
              horizontal: 24  
            ),
            child: Text(
              order!.bantuan!.title,
              style: baseBlackSemibold,
            ),
          ),
        ],
      );
    }
    
    Widget BantuanDetails() {
      return Marginner(
        margin: EdgeInsets.symmetric(
          horizontal: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriceStartItem(
              price: order!.bantuan!.price,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Description',
              desc: order!.bantuan!.desc,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Location',
              desc: order!.bantuan!.location.split('|')[1],
            ),
            SizedBox(height: 24,),
          ],
        ),
      );
    }

    Widget CancelHelperContent() {
      return StatefulBuilder(
        builder: ((BuildContext context, StateSetter setState) {
          return Container(
            margin: EdgeInsets.only(
              top: 24
            ),
            child: ListView(
              padding: EdgeInsets.only(
                bottom: 72
              ),
              children: [
                ImageCustom(
                  width: 180,
                  height: 180,
                  image: AssetImage('assets/illustrations/il_cry.png'),
                ),
                Marginner(
                  margin: EdgeInsets.all(24),
                  child: Text(
                    'Helper sedih nih, kamu yakin mau batalin bantuan dari helper?',
                    style: mediumBlackSemibold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Line(),
                SizedBox(height: 24,),
                Text(
                  'Berikan alasan kamu dong : ',
                  style: regularBlackRegular,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                    horizontal: 24
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    children: cancels.map((data) {
                      return CancelItem(
                        text: data,
                        onPressed: (){
                          selectReason(data, setState);
                        },
                        selected: isContain(data),
                      );
                    }).toList()
                  ),
                ),
                SizedBox(height: 24,),
                Text(
                  'Boleh Beri Alasan Detail Dari Kamu Dong',
                  style: regularBlackRegular,
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 6
                  ),
                  child: TextField(
                    onChanged: (value){
                      onChange(value, setState);
                    },
                    controller: reasonController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    style: mediumBlackRegular,
                    decoration: InputDecoration (
                      hintText: 'Masukkan Alasan',
                      hintStyle: mediumPrimaryRegular.copyWith(
                        color: green3
                      ),
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: green3
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 21,
                      right: 21
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: green1
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    ),
                  ),
                ),
                Marginner(
                  margin: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 24
                  ),
                  child: MainButtonCustom(
                    title: 'Batalkan',
                    onPressed: (){
                      onCancel();
                    },
                    type: 'danger',
                    disabled: selected.length < 1 && currentReason == "",
                  ),
                ),
                SizedBox(height: 240,)
              ],
            ),
          );
        }),
      );
    }

    Widget DoneHelperContent() {
      return StatefulBuilder(
        builder: ((BuildContext context, StateSetter setState) {
          return Container(
            margin: EdgeInsets.only(
              top: 24
            ),
            child: ListView(
              children: [
                ImageCustom(
                  width: 180,
                  height: 180,
                  image: AssetImage('assets/illustrations/il_think.png'),
                ),
                Marginner(
                  margin: EdgeInsets.all(24),
                  child: Text(
                    'Apa kamu yakin mau selesain bantuan yg kamu request ke helper?',
                    style: mediumBlackSemibold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Line(),
                SizedBox(height: 24,),
                Text(
                  'Kasih rating buat helper dulu dong',
                  style: regularBlackRegular,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16,),
                Marginner(
                  margin: EdgeInsets.symmetric(
                    horizontal: 48
                  ),
                  child: RateControl(
                    rate: rating,
                    onPress: setRate,
                    setState: setState,
                  )
                ),
                SizedBox(height: 24,),
                Text(
                  'Beri ulasan kamu ke helper yuk',
                  style: regularBlackRegular,
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 6
                  ),
                  child: TextField(
                    onChanged: (value){
                      onChange(value, setState);
                    },
                    controller: reasonController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    style: mediumBlackRegular,
                    decoration: InputDecoration (
                      hintText: 'Masukkan Alasan',
                      hintStyle: mediumPrimaryRegular.copyWith(
                        color: green3
                      ),
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: green3
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 21,
                      right: 21
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: green1
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    ),
                  ),
                ),
                Marginner(
                  margin: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 24
                  ),
                  child: MainButtonCustom(
                    title: 'Selesai',
                    onPressed: (){
                      onComplete();
                    },
                    disabled: rating == 0,
                  ),
                ),
                SizedBox(height: 240,)
              ],
            ),
          );
        }),
      );
    }

    Widget BottomButton() {
      return Container(
        padding: EdgeInsets.all(16),
        height: 76,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.9),
              blurRadius: 9,
              offset: Offset(0, 9)
            )
          ]
        ),
        child: Row(
          children: [
            ChatBtn(
              onPressed: (){
              },
              isDetail: true,
            ),
            SizedBox(width: 12,),
            Expanded(
              child: DetailButtonCustom(
                color: red1,
                title: 'Batal',
                onPressed: (){
                  showDrawer(context, screenHeightPercentage(context, 0.8), CancelHelperContent());
                },
                icon: ImageCustom(
                  width: 24,
                  height: 24,
                  image: AssetImage('assets/icons/ic_cross_btn.png'),
                ),
              ),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: DetailButtonCustom(
                title: 'Selesai',
                onPressed: (){
                  showDrawer(context, screenHeightPercentage(context, 0.7), DoneHelperContent());
                },
                icon: ImageCustom(
                  width: 24,
                  height: 19,
                  image: AssetImage('assets/icons/ic_check_btn.png'),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget Processing() {
      return Container(
        color: black.withOpacity(0.5),
        child: LoadingCustom(
          title: loadingTitle,
          isWhite: true,
        ),
      );
    }

    Widget MainContent() {
      return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  HeaderContent(),
                  Expanded(
                    child: ListView(
                      children: [
                        ImageAndTitle(),
                        Marginner(
                          margin: EdgeInsets.symmetric(
                            vertical: 24
                          ),
                          child: Line()
                        ),
                        BantuanDetails(),
                        OwnerItem(
                          ownerImage: '',
                          title: order!.helper!.user!.fullName,
                          subTitle: 'Helper Kamu',
                          network: true,
                          nwUrl: order!.helper!.user!.image,
                          onPressed: (){},
                        ),
                        RenderPayType(),
                        order!.status == 'done' ? SizedBox() : BottomButton()
                      ],
                    ),
                  )
                ],
              ),
              loading ? Processing() : SizedBox()
            ],
          ),
        ),
      );
    }

    Widget LoadingContent() {
      return Scaffold(
        body: Container(
          child: LoadingCustom(
            title: 'Loading . . .',
          ),
        ),
      );
    }

    return order == null ? LoadingContent() : MainContent();
  }
}