import 'dart:async';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_category_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/bantuan_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/detail_page_items/payment_summary.dart';
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
import 'package:bantuin/widgets/title_descs/detail_title_desc.dart';
import 'package:bantuin/widgets/toggler/multiple_toggler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateSummaryPage extends StatefulWidget {
  @override
  State<CreateSummaryPage> createState() => _CreateSummaryPageState();

  var pickedImage;
  String title, desc, location;
  int price;
  LatLng locationLatLng;
  BantuanCategoryModel category;

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
  late var userVm = UserViewModel(context);
  late var bantuanVm = BantuanViewModel(context);
  late var user = userVm.getUserData();

  var currentToggle = 'Bantuan Money';
  var toggles = ['Bantuan Money', 'Midtrans Payment', 'Cash on Delivery'];
  void changeToggle(toggle) {
    this.setState(() {
      currentToggle = toggle;
    });
  }
  String getPayType() {
    return currentToggle == "Bantuan Money" ? 'bmoney' : currentToggle == "Midtrans Payment" ? "midtrans" : 'cash';
  }
  late var currentBM = user.balance;
  late var keyVals = [
    ['Full Name', user.fullName],
    ['Email address', user.email],
    ['Phone Number', user.phoneNumber],
  ];

  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }
  
  var paymentUrl = "";
  void createBantuan() async {
    toggleLoading(true);
    var result = await bantuanVm.createBantuan(
      price: this.widget.price,
      categoryId: this.widget.category.id,
      image: this.widget.pickedImage.path,
      title: this.widget.title,
      desc: this.widget.desc,
      location: "${(this.widget.locationLatLng.longitude).toString()},${(this.widget.locationLatLng.latitude).toString()}|${this.widget.location}",
      payType: getPayType()
    );
    toggleLoading(false);
    
    if (getPayType() == "midtrans") {
      if (result != "") {
        this.setState(() {
          paymentUrl = result;
        });
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/processing-page', (route) => false);
    }
  }

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
          name: user.fullName,
          phone: user.phoneNumber,
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
                createBantuan();
              },
            )
          ],
        ),
      );
    }

    Widget PaymentContent() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Midtrans Payment"),
          backgroundColor: green1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: (){
              this.setState(() {
                paymentUrl = "";
              });
              Timer(Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(context, '/processing-page', (route) => false);
              });
            },
          ),
        ),
        body: WebView(
          initialUrl: paymentUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      );
    }

    Widget LoadingContent() {
      return Container(
        color: black.withOpacity(0.5),
        child: LoadingCustom(title: "Creating Bantuan . . .", isWhite: true,),
      );
    }

    Widget DefaultContent() {
      return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
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
                                createBantuan();
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
              loading ? LoadingContent() : SizedBox()
            ],
          )
        ),
      );
    }

    return paymentUrl != "" ? PaymentContent() : DefaultContent();
  }
}