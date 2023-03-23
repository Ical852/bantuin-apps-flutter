import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/pages/bantuan_pages/my_bantuan_helper_request.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/detail_button_custom.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/cancel_item.dart';
import 'package:bantuin/widgets/chat_items/chat_btn.dart';
import 'package:bantuin/widgets/detail_page_items/price_start_item.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_desc_btn.dart';
import 'package:bantuin/widgets/line.dart';
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
  var payType = 'bmoney';

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
    return  selected.contains(reason);
  }

  void onChange(reason, setState) {
    this.setState(() {
      currentReason = reason;
    });
    setState((){
      currentReason = reason;
    });
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
          price: 6000000,
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
          total: 6000000,
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
          name: 'Budi Setianto',
          phone: '089674839221',
          price: 0,
          noMain: true,
          plus: 6000000,
          title: 'Helper akan mendapatkan',
        ),
      );
    }

    Widget RenderPayType() {
      return payType == 'bmoney' ? BMoneyPayType()
      : payType == 'midtrans' ? MidtransPayType()
      : CODPayType();
    }

    Widget ImageAndTitle() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCustom(
            height: 227,
            width: double.infinity,
            image: AssetImage('assets/dummies/dummy1.png'),
            margin: EdgeInsets.symmetric(
              horizontal: 24
            ),
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(12),
          ),
          SizedBox(height: 24,),
          Marginner(
            margin: EdgeInsets.symmetric(
              horizontal: 24  
            ),
            child: Text(
              'Jadi Keamanan Camping Hutan Mangroove',
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
              price: 6000000,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Description',
              desc: 'Jadi kemanan camping gua ngejaga malam pagi siang dan sore, 18 jam, fasilitas tersedia semua, senter, tenda, terpal, karpet, makan pagi, siang, sore, malem, dijamin komplit.',
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Location',
              desc: 'Jl. Cemara 2, Poris Indah Blok H 40, Tangerang, Banten',
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
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showGLobalAlert('success', "Berhasil membatalkan bantuan", context);
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
                      Navigator.pushNamed(context, "/my-bantuan-done");
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

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
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
                    ownerImage: 'assets/dummies/owner.png',
                    title: 'Budi Setianto',
                    subTitle: 'Helper Kamu',
                    onPressed: (){},
                  ),
                  RenderPayType(),
                  BottomButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}