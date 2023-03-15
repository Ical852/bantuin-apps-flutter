import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/pages/bantuan_pages/my_bantuan_helper_request.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/detail_button_custom.dart';
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
import 'package:bantuin/widgets/title_descs/detail_title_desc.dart';
import 'package:flutter/material.dart';

class MyBantuanDetailAcceptedPage extends StatefulWidget {
  @override
  State<MyBantuanDetailAcceptedPage> createState() => _MyBantuanDetailAcceptedPageState();
}

class _MyBantuanDetailAcceptedPageState extends State<MyBantuanDetailAcceptedPage> {
  var payType = 'bmoney';

  @override
  Widget build(BuildContext context) {
    Widget HeaderContent() {
      return MainHeader(
        title: 'Detail Bantuin',
        onBack: (){
          Navigator.pop(context);
        },
        rightContent: Container(
          height: 24,
          width: 24,
          child: Stack(
            children: [
              ImageCustom(
                width: 17,
                height: 20,
                image: AssetImage('assets/icons/ic_notif_chat.png'),
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 11,
                  height: 11,
                  margin: EdgeInsets.only(
                    right: 4
                  ),
                  decoration: BoxDecoration(
                    color: red1,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Text(
                      "2",
                      style: xSmallWhiteMedium.copyWith(
                        fontSize: 5
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onRightPress: (){
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => MyBantuanHelperRequestPage(),
            )
          );
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

    Widget RequestHelperContent() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(
              height: 24,
            ),
            ImgDescBtn(
              image: 'assets/illustrations/il_obhelp.png',
              title: 'Daftar',
              desc: 'Request ke admin untuk mendaftar menjadi helper?',
              onPress: () {
                Navigator.pushNamed(context, '/request-success');
              },
            )
          ],
        ),
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
                title: 'Bantuin',
                onPressed: (){
                  showDrawer(context, 398, RequestHelperContent());
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
                  showDrawer(context, 398, RequestHelperContent());
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
                    subTitle: 'Butuh Bantuan',
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