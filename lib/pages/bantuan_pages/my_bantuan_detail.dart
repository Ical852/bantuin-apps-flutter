import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/pages/bantuan_pages/my_bantuan_helper_request.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/bantuan_order_view_model.dart';
import 'package:bantuin/view_models/bantuan_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/detail_button_custom.dart';
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
import 'package:bantuin/widgets/title_descs/detail_title_desc.dart';
import 'package:flutter/material.dart';

class MyBantuanDetailPage extends StatefulWidget {
  @override
  State<MyBantuanDetailPage> createState() => _MyBantuanDetailPageState();

  BantuanModel bantuan;
  MyBantuanDetailPage(this.bantuan);
}

class _MyBantuanDetailPageState extends State<MyBantuanDetailPage> {
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();
  late var bantuanOrderVm = BantuanOrderViewModel(context);
  late var bantuanVm = BantuanViewModel(context);
  List<BantuanOrderModel> request = [];

  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void getBantuanOrderRequest() async {
    var result = await bantuanOrderVm.getBantuanByUserId(
      bantuanId: this.widget.bantuan.id
    );
    this.setState(() {
      request = result;
    });
  }

  void deleteBantuan() async {
    toggleLoading(true);
    var result = await bantuanVm.deleteBantuan(bantuanId: this.widget.bantuan.id);
    toggleLoading(false);
    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    getBantuanOrderRequest();
  }

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
              request.length > 0 ? Align(
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
                      request.length.toString(),
                      style: xSmallWhiteMedium.copyWith(
                        fontSize: 5
                      ),
                    ),
                  ),
                ),
              ) : SizedBox()
            ],
          ),
        ),
        onRightPress: (){
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => MyBantuanHelperRequestPage(request),
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
          price: this.widget.bantuan.price,
          accepted: true,
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
          total: this.widget.bantuan.price,
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
          name: user.fullName,
          phone: user.phoneNumber,
          price: 0,
          noMain: true,
          plus: this.widget.bantuan.price,
          title: 'Helper akan mendapatkan',
        ),
      );
    }

    Widget RenderPayType() {
      return this.widget.bantuan.payType == 'bmoney' ? BMoneyPayType()
      : this.widget.bantuan.payType == 'midtrans' ? MidtransPayType()
      : CODPayType();
    }

    Widget ImageAndTitle() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCustom(
            height: 227,
            width: double.infinity,
            network: true,
            nwUrl: this.widget.bantuan.image,
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
              this.widget.bantuan.title,
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
              price: this.widget.bantuan.price,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Description',
              desc: this.widget.bantuan.desc,
            ),
            SizedBox(height: 20,),
            DetailTitleDesc(
              title: 'Location',
              desc: this.widget.bantuan.location.split('|')[1],
            ),
            SizedBox(height: 24,),
          ],
        ),
      );
    }

    Widget DeleteBantuanContent() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(
              height: 24,
            ),
            ImgDescBtn(
              image: 'assets/illustrations/il_question.png',
              title: 'Hapus',
              desc: 'Kamu yakin untuk menghapus bantuan ini?',
              onPress: () {
                deleteBantuan();
              },
              type: 'danger',
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
            Expanded(
              child: DetailButtonCustom(
                color: red1,
                title: 'Hapus Minta Bantuan',
                onPressed: (){
                  showDrawer(context, 358, DeleteBantuanContent());
                },
                icon: ImageCustom(
                  width: 24,
                  height: 24,
                  image: AssetImage('assets/icons/ic_cross_btn.png'),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget LoadingContent() {
      return Container(
        color: black.withOpacity(0.5),
        child: LoadingCustom(
          title: 'Deleting Bantuan . . .',
          isWhite: true,
        ),
      );
    }

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
                      Line(),
                      RenderPayType(),
                      BottomButton()
                    ],
                  ),
                )
              ],
            ),
            loading ? LoadingContent() : SizedBox()
          ],
        ),
      ),
    );
  }
}