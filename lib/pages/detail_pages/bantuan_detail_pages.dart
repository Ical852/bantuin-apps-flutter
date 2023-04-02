import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/pages/detail_pages/detail_map_page.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/bantuan_order_view_model.dart';
import 'package:bantuin/view_models/helper_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/detail_button_custom.dart';
import 'package:bantuin/widgets/buttons/mini_button_custom.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
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
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BantuanDetailPage extends StatefulWidget {
  @override
  State<BantuanDetailPage> createState() => _BantuanDetailPageState();

  BantuanModel bantuan;
  BantuanDetailPage(this.bantuan);
}

class _BantuanDetailPageState extends State<BantuanDetailPage> {
  late var userVm = UserViewModel(context);
  late var helperVm = HelperViewModel(context);
  late var boVm = BantuanOrderViewModel(context);
  late var user = userVm.getUserData();

  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void requestToBeHelper() async {
    Navigator.pop(context);
    toggleLoading(true);
    var result = await helperVm.requestToBeHelper();
    toggleLoading(false);

    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, '/request-success', (route) => false);
    }
  }

  String getLocation() {
    return this.widget.bantuan.location.split('|')[1];
  }

  LatLng getLatLong() {
    var latLngString = this.widget.bantuan.location.split('|')[0];
    var latLngSplit = latLngString.split(',');
    var lat = double.parse(latLngSplit[0]);
    var long = double.parse(latLngSplit[1]);
    return LatLng(lat, long);
  }

  void requestBantuan() async {
    Navigator.pop(context);

    toggleLoading(true);
    var result = await boVm.createOrder(
      userId: this.widget.bantuan.userId,
      helperId: user.helper!.id,
      bantuanId: this.widget.bantuan.id
    );
    toggleLoading(false);

    if (result) {
      setPage(context, 'profile');
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          name: this.widget.bantuan.user!.fullName,
          phone: this.widget.bantuan.user!.phoneNumber,
          price: 0,
          noMain: true,
          plus: this.widget.bantuan.price,
          title: 'Bantuin Money Anda Akan Bertambah +',
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
            margin: EdgeInsets.symmetric(
              horizontal: 24
            ),
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(12),
            network: true,
            nwUrl: this.widget.bantuan.image,
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
              desc: getLocation(),
            ),
            SizedBox(height: 8,),
            RawButtonCustom(
              height: 40,
              onPress: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => DetailMapPage(this.widget.bantuan.user!, getLatLong()),
                  )
                );
              },
              title: 'Check',
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
                requestToBeHelper();
              },
            )
          ],
        ),
      );
    }

    Widget RequestHelperAccept() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(
              height: 24,
            ),
            ImgDescBtn(
              image: 'assets/illustrations/il_obhelp.png',
              title: 'Bantu',
              desc: 'Request Bantu ke Bantuan ' + this.widget.bantuan.user!.fullName + " ?",
              onPress: () {
                requestBantuan();
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
                title: 'Bantuin',
                onPressed: (){
                  if (user.helper == null || user.helper?.status == 'pending') {
                    showDrawer(context, 398, RequestHelperContent());
                  } else {
                    showDrawer(context, 398, RequestHelperAccept());
                  }
                },
                icon: ImageCustom(
                  width: 16,
                  height: 16.2,
                  image: AssetImage('assets/icons/ic_next.png'),
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
        child: Stack(
          children: [
            Column(
              children: [
                MainHeader(
                  title: 'Detail Bantuin',
                  onBack: (){
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 12
                    ),
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
                        ownerImage: '',
                        title: this.widget.bantuan.user!.fullName,
                        subTitle: 'Butuh Bantuan',
                        network: true,
                        nwUrl: this.widget.bantuan.user!.image,
                        onPressed: (){},
                      ),
                      RenderPayType(),
                      BottomButton()
                    ],
                  ),
                )
              ],
            ),
            loading ? Container(
              color: black.withOpacity(0.5),
              child: LoadingCustom(
                title: 'Requesting . . .',
                isWhite: true,
              ),
            ) : SizedBox()
          ],
        )
      ),
    );
  }
}