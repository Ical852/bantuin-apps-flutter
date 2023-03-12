import 'dart:io';

import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/detail_page_items/payment_summary.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money_profile.dart';
import 'package:bantuin/widgets/money_contents/midtrans_pay.dart';
import 'package:flutter/material.dart';

class TopUpSummaryPage extends StatefulWidget {
  @override
  State<TopUpSummaryPage> createState() => _TopUpSummaryPageState();

  int total;
  TopUpSummaryPage(this.total);
}

class _TopUpSummaryPageState extends State<TopUpSummaryPage> {

  var keyVals = [
    ['Nama Anda', 'Shalahuddin Ahmad Aziz'],
    ['Email Anda', 'shalahuddin@gmail.com'],
    ['Nomor Telepon', '089674839221']
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(
              title: 'Top Up Summary',
              onBack: (){
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 12,),
                  Marginner(
                    margin: EdgeInsets.symmetric(
                      horizontal: 24
                    ),
                    child: BantuanMoneyProfile(
                      name: 'Shalahuddin Ahmad Aziz',
                      phone: '089674839221',
                      price: 9200301,
                      plus: this.widget.total,
                    ),
                  ),
                  SizedBox(height: 24,),
                  PaymentSummary(
                    keyVals: keyVals,
                    total: this.widget.total,
                  ),
                  SizedBox(height: 24,),
                  MidtransPay(),
                  SizedBox(height: 24),
                  Line(),
                  Marginner(
                    margin: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 32,
                      bottom: Platform.isIOS ? 52 : 32
                    ),
                    child: MainButtonCustom(
                      title: 'Top Up',
                      onPressed: (){
                        Navigator.pushNamed(context, '/top-up-success');
                      },
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