import 'dart:async';
import 'dart:io';

import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/view_models/transaction_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/detail_page_items/payment_summary.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money_profile.dart';
import 'package:bantuin/widgets/money_contents/midtrans_pay.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TopUpSummaryPage extends StatefulWidget {
  @override
  State<TopUpSummaryPage> createState() => _TopUpSummaryPageState();

  int total;
  TopUpSummaryPage(this.total);
}

class _TopUpSummaryPageState extends State<TopUpSummaryPage> {
  late var userVm = UserViewModel(context);
  late var trxVm = TransactionViewModel(context);
  late var user = userVm.getUserData();

  var paymentUrl = "";
  late var keyVals = [
    ['Nama Anda', user.fullName],
    ['Email Anda', user.email],
    ['Nomor Telepon', user.phoneNumber]
  ];

  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void onTopUp() async {
    toggleLoading(true);
    var result = await trxVm.topUp(grossAmount: this.widget.total);
    toggleLoading(false);

    this.setState(() {
      paymentUrl = result;
    });
  }

  @override
  Widget build(BuildContext context) {

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
                Navigator.pushNamedAndRemoveUntil(context, '/top-up-success', (route) => false);
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
        child: LoadingCustom(
          title: "Creating Transaction . . .",
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
                  MainHeader(
                    title: 'Top Up Summary',
                    onBack: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Marginner(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: BantuanMoneyProfile(
                            name: user.fullName,
                            phone: user.phoneNumber,
                            price: user.balance,
                            plus: this.widget.total,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        PaymentSummary(
                          keyVals: keyVals,
                          total: this.widget.total,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        MidtransPay(),
                        SizedBox(height: 24),
                        Line(),
                        Marginner(
                          margin: EdgeInsets.only(
                              left: 24,
                              right: 24,
                              top: 32,
                              bottom: Platform.isIOS ? 52 : 32),
                          child: MainButtonCustom(
                            title: 'Top Up',
                            onPressed: () {
                              onTopUp();
                            },
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
    
    return paymentUrl != "" ? PaymentContent() : MainContent();
  }
}