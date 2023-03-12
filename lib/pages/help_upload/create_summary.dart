import 'dart:io';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/detail_page_items/payment_summary.dart';
import 'package:bantuin/widgets/detail_page_items/price_start_item.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_desc_btn.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money_profile.dart';
import 'package:bantuin/widgets/money_contents/cash_on_delivery.dart';
import 'package:bantuin/widgets/money_contents/midtrans_pay.dart';
import 'package:bantuin/widgets/title_descs/detail_title_desc.dart';
import 'package:bantuin/widgets/toggler/multiple_toggler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateSummaryPage extends StatefulWidget {
  @override
  State<CreateSummaryPage> createState() => _CreateSummaryPageState();

  var pickedImage;
  String title, desc, category, location;
  int price;
  LatLng locationLatLng;

  CreateSummaryPage(
    this.pickedImage,
    this.title,
    this.desc,
    this.category,
    this.location,
    this.price,
    this.locationLatLng
  );
}

class _CreateSummaryPageState extends State<CreateSummaryPage> {
  var currentToggle = 'Bantuan Money';
  var toggles = ['Bantuan Money', 'Midtrans Payment', 'Cash on Delivery'];
  void changeToggle(toggle) {
    this.setState(() {
      currentToggle = toggle;
    });
  }

  var currentBM = 500000;

  var keyVals = [
    ['Full Name', 'Shalahuddin Ahmad Aziz'],
    ['Email address', 'shalahuddin@gmail.com'],
    ['Phone Number', '089674839221'],
  ];

  
  @override
  Widget build(BuildContext context) {
    Widget ImageAndTitle() {
      return Marginner(
        margin: EdgeInsets.only(
          left: 24,
          right: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCustom(
              height: 227,
              width: double.infinity,
              image: FileImage(this.widget.pickedImage),
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(12),
            ),
            SizedBox(height: 24,),
            Text(
              this.widget.title,
              style: baseBlackSemibold,
              maxLines: 2,
            ),
            SizedBox(height: 24,),
          ],
        ),
      );
    }

    Widget BantuanDetails() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriceStartItem(
              price: this.widget.price,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Description',
              desc: this.widget.desc,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Location',
              desc: this.widget.location,
            ),
            SizedBox(height: 24,),
          ],
        ),
      );
    }

    Widget BMContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24
        ),
        child: BantuanMoneyProfile(
          name: 'Shalahuddin Ahmad Aziz',
          phone: '089674839221',
          price: currentBM,
          minus: this.widget.price,
        ),
      );
    }

    Widget MidtransContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 24
        ),
        child: MidtransPay(),
      );
    }

    Widget CODContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24
        ),
        child: CashOnDelivery(
          price: this.widget.price,
        ),
      );
    }

    Widget PaymentRender() {
      return currentToggle == 'Bantuan Money' ? BMContent()
      : currentToggle == 'Midtrans Payment' ? MidtransContent()
      : CODContent();
    }

    Widget PaymentMethod() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Marginner(
              margin: EdgeInsets.only(
                top: 16,
                left: 24,
                right: 24,
                bottom: 24
              ),
              child: DetailTitleDesc(
                title: 'Pilih Tipe Pembayaran',
                desc: 'Pilih tipe pembayaran kamu untuk melanjutkan pencarian bantuan',
              ),
            ),
            MultipleToggler(
              toggles: toggles,
              current: currentToggle,
              onPress: changeToggle,
            ),
            PaymentRender(),
            SizedBox(height: 24,)
          ],
        ),
      );
    }

    Widget CODDrawerContent() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24
        ),
        child: ListView(
          children: [
            SizedBox(height: 24,),
            ImgDescBtn(
              image: 'assets/illustrations/il_ok_drawer.png',
              title: 'Lanjutkan',
              desc: 'Pastikan Kamu Punya Uang Cash yang Pas Untuk Bayar Nanti Yaa',
              onPress: (){
                Navigator.pushNamed(context, '/processing-page');
              },
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
            MainHeader(
              title: 'Pembayaran',
              onBack: (){
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 12,),
                  ImageAndTitle(),
                  Line(),
                  BantuanDetails(),
                  Line(),
                  PaymentMethod(),
                  PaymentSummary(
                    keyVals: keyVals,
                    total: this.widget.price,
                  ),
                  Marginner(
                    margin: EdgeInsets.only(
                      top: 32,
                      left: 24,
                      right: 24,
                      bottom: 32
                    ),
                    child: MainButtonCustom(
                      title: 'Cari Bantuan',
                      onPressed: (){
                        if (currentToggle == 'Cash on Delivery') {
                          showDrawer(context, 398, CODDrawerContent());
                        } else {
                          Navigator.pushNamed(context, '/processing-page');
                        }
                      },
                      disabled: currentToggle == 'Bantuan Money' && this.widget.price > currentBM,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}