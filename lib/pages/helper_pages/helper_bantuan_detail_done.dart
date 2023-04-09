import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/pages/chat_pages/detail_chat_page_helper.dart';
import 'package:bantuin/pages/detail_pages/detail_map_page.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/chat_view_model.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
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
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HelperBantuanDetailDonePage extends StatefulWidget {
  @override
  State<HelperBantuanDetailDonePage> createState() => _HelperBantuanDetailDonePageState();

  BantuanOrderModel order;
  HelperBantuanDetailDonePage(this.order);
}

class _HelperBantuanDetailDonePageState extends State<HelperBantuanDetailDonePage> {
  @override

  late var payType = this.widget.order.bantuan!.payType;
  late var chatVm = ChatViewModel(context);

  String getLocation() {
    return this.widget.order.bantuan!.location.split('|')[1];
  }

  LatLng getLatLong() {
    var latLngString = this.widget.order.bantuan!.location.split('|')[0];
    var latLngSplit = latLngString.split(',');
    var lat = double.parse(latLngSplit[0]);
    var long = double.parse(latLngSplit[1]);
    return LatLng(long, lat);
  }

  void goToChat(int userId, int helperId, UserModel helper) async {
    var result = await chatVm.createChat(
      userId: userId,
      helperId: helperId
    );

    if (result) {
      Navigator.push(
        context, MaterialPageRoute(
          builder: (context) => DetailChatPageHelper('${userId}_${helperId}', helper)
        )
      );
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
          price: this.widget.order.bantuan!.price,
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
          total: this.widget.order.bantuan!.price,
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
          name: this.widget.order.bantuan!.user!.fullName,
          phone: this.widget.order.bantuan!.user!.phoneNumber,
          price: 0,
          noMain: true,
          plus: this.widget.order.bantuan!.price,
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
            margin: EdgeInsets.symmetric(
              horizontal: 24
            ),
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(12),
            network: true,
            nwUrl: this.widget.order.bantuan!.image,
          ),
          SizedBox(height: 24,),
          Marginner(
            margin: EdgeInsets.symmetric(
              horizontal: 24  
            ),
            child: Text(
              this.widget.order.bantuan!.title,
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
              price: this.widget.order.bantuan!.price,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Description',
              desc: this.widget.order.bantuan!.desc,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Location',
              desc: getLocation(),
            ),
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
                  Marginner(
                    margin: EdgeInsets.only(top: 24),
                    child: Line()
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