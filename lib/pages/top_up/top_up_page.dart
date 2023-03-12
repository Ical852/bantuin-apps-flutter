import 'dart:io';

import 'package:bantuin/pages/top_up/top_up_summary.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/buttons/mini_icon_button_custom.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money_profile.dart';
import 'package:bantuin/widgets/price_items/row_price_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopUpPage extends StatefulWidget {
  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController priceController = TextEditingController(text: "");
  var currentPrice = 0;
  var prices = [
    [50000, 100000], [200000, 300000], [500000, 1000000]
  ];
  void setFastPrice(price) {
    priceController.text = price.toString();
    this.setState(() {
      currentPrice = price;
    });
  }
  bool isPriceActive(price) {
    return currentPrice == price;
  }
  bool isDisabled() {
    return currentPrice < 50000;
  }

  @override
  Widget build(BuildContext context) {
    Widget HeaderBackground() {
      return Container(
        height: 155,
        decoration: BoxDecoration(
          color: green1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12)
          )
        ),
      );
    }

    Widget HeaderContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 55,
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MiniIconButtonCustom(
                  height: 11.5,
                  width: 7.2,
                  icons: 'assets/icons/ic_chevron_left.png',
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Bantuin Money Top Up',
                  style: regularWhiteSemibold,
                ),
                SizedBox(width: 7.2,)
              ],
            ),
            SizedBox(height: 27,),
            BantuanMoneyProfile(
              name: 'Shalahuddin Ahmad Aziz',
              phone: '089674839221',
              price: 9200301,
            ),
            SizedBox(height: 32,),
            Line()
          ],
        ),
      );
    }

    Widget FastTopUpContent() {
      return Column(
        children: prices.map((price) {
          return RowPriceItem(
            leftPrice: price[0],
            rightPrice: price[1],
            onLeft: (){
              setFastPrice(price[0]);
            },
            onRight: (){
              setFastPrice(price[1]);
            },
            leftActive: isPriceActive(price[0]),
            rightActive: isPriceActive(price[1]),
          );
        }).toList(),
      );
    }

    Widget ManualTopUpContent() {
      return Row(
        children: [
          Text(
            'IDR.',
            style: extraBlackSemibold,
          ),
          SizedBox(width: 10,),
          Expanded(
            child: TextFormField(
              style: extraBlackSemibold,
              decoration: InputDecoration.collapsed(
                hintText: '',
                hintStyle: extraBlackSemibold
              ),
              keyboardType: TextInputType.numberWithOptions(
                signed: true,
                decimal: true
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: priceController,
              onChanged: (value) {
                if (value != "") {
                  this.setState(() {
                    currentPrice = int.parse(value);
                  });
                }
              },
            ),
          )
        ],
      );
    }

    Widget MainContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 303,
          left: 24,
          right: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fast Top Up :',
              style: regularPrimarySemibold,
            ),
            SizedBox(height: 12,),
            FastTopUpContent(),
            SizedBox(height: 24,),
            Text(
              'Manual Amount',
              style: regularPrimarySemibold,
            ),
            SizedBox(height: 14,),
            ManualTopUpContent(),
            SizedBox(height: 120,),
            Line(),
            Marginner(
              margin: EdgeInsets.only(
                top: 32,
                bottom: Platform.isIOS ? 52 : 32
              ),
              child: MainButtonCustom(
                title: 'Lanjutkan',
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => TopUpSummaryPage(currentPrice)
                    )
                  );
                },
                disabled: isDisabled(),
              ),
            )
          ],
        ),
      );
    }
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            HeaderBackground(),
            HeaderContent(),
            MainContent()
          ],
        ),
      ),
    );
  }
}