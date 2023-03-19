import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/detail_page_items/price_start_item.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money_profile.dart';
import 'package:bantuin/widgets/money_contents/cash_on_delivery.dart';
import 'package:bantuin/widgets/money_contents/midtrans_pay.dart';
import 'package:bantuin/widgets/owner_item.dart';
import 'package:bantuin/widgets/title_descs/detail_title_desc.dart';
import 'package:flutter/material.dart';

class HelperBantuanDetailOnGoingPage extends StatefulWidget {
  @override
  State<HelperBantuanDetailOnGoingPage> createState() => _HelperBantuanDetailOnGoingPageState();
}

class _HelperBantuanDetailOnGoingPageState extends State<HelperBantuanDetailOnGoingPage> {
  var payType = 'bmoney';

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
                    subTitle: 'Butuh Bantuan',
                    onPressed: (){},
                  ),
                  RenderPayType(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}