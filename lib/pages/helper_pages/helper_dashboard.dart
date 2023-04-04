import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/models/helper_rate_model.dart';
import 'package:bantuin/pages/helper_pages/helper_bantuan_detail_done.dart';
import 'package:bantuin/pages/helper_pages/helper_bantuan_detail_on_going.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/view_models/bantuan_order_view_model.dart';
import 'package:bantuin/view_models/helper_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/helper_items/helper_insight.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/line.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:bantuin/widgets/main_items/weekly_item.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money_profile.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:bantuin/widgets/toggler/double_text_toggler.dart';
import 'package:flutter/material.dart';

class HelperDashboardPage extends StatefulWidget {
  @override
  State<HelperDashboardPage> createState() => _HelperDashboardPageState();
}

class _HelperDashboardPageState extends State<HelperDashboardPage> {
  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();
  late var helperVm = HelperViewModel(context);
  late var orderVm = BantuanOrderViewModel(context);

  List<HelperRateModel> data = [];
  var totalRecords = 0;
  var totalRate = 0.0;
  void getAllRecords() async {
    toggleLoading(true);
    var result = await helperVm.getAllRecords(helperId: user.helper!.id);
    toggleLoading(false);

    this.setState(() {
      data = result;
      totalRecords = result.length;
      totalRate = double.parse(result.map((m) => m.rating).reduce((a, b) => a + b).toString());
    });
  }

  var currentToggle = "left";
  void toggleToggler(value) {
    this.setState(() {
      currentToggle = value;
    });
  }

  List<BantuanOrderModel> onGoingData = [];
  List<BantuanOrderModel> doneData = [];

  void getOnGoingData() async {
    toggleLoading(true);
    var result = await orderVm.getHelperOrderByStatus(
      helperId: user.helper!.id,
      status: 'process'
    );
    toggleLoading(false);

    this.setState(() {
      onGoingData = result;
    });
  }

  void getDoneData() async {
    toggleLoading(true);
    var result = await orderVm.getHelperOrderByStatus(
      helperId: user.helper!.id,
      status: 'done'
    );
    toggleLoading(false);

    this.setState(() {
      doneData = result;
    });
  }

  @override
  void initState() {
    super.initState();

    getOnGoingData();
    getDoneData();
  }

  @override
  Widget build(BuildContext context) {
    Widget HelperBM() {
      return Marginner(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: BantuanMoneyProfile(
          name: user.fullName,
          phone: user.phoneNumber,
          price: user.balance,
        ),
      );
    }

    Widget HelperInsightContent() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTitleDesc(
                title: 'Insight Helper Kamu',
                desc: 'Insight selama kamu sebagai helper'),
            SizedBox(
              height: 16,
            ),
            HelperInsight(
              money: user.helper!.helperBalance,
              totalHelp: totalRecords,
              rate: totalRate,
              onMoney: () {},
              onHelp: () {},
              onRate: () {},
            ),
            SizedBox(
              height: 32,
            )
          ],
        ),
      );
    }

    Widget ContentToggler() {
      return DoubleTextToggler(
        current: currentToggle,
        left: 'Sedang Berjalan',
        right: 'Telah Selesai',
        leftPress: () => toggleToggler('left'),
        rightPress: () => toggleToggler('right'),
      );
    }

    Widget LeftEmpty() {
      return Container(
        margin: EdgeInsets.only(
          top: 32
        ),
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_empty_bantuan.png',
          title: 'Ups, Kosong',
          desc: 'Wah, sepertinya kamu belum pernah membantu customer, cek home untuk mencoba membantu customer',
          width: 270,
          btnTitle: 'Ke Home',
          onPressed: (){
            setPage(context, 'home');
            Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
          },
        ),
      );
    }

    Widget LeftExist() {
      return Container(
        margin: EdgeInsets.only(
          top: 32,
          left: 24,
          right: 24
        ),
        child: Column(
          children: onGoingData.map((order) {
            return WeeklyItem(
              bantuan: order.bantuan!,
              onPress: () {
                print(order.status);
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperBantuanDetailOnGoingPage(order),
                  )
                );
              },
              isHelper: true,
            );
          }).toList(),
        ),
      );
    }

    Widget LeftContentRender() {
      return onGoingData.length > 0 ? LeftExist() : LeftEmpty();
    }

    Widget RightEmpty() {
      return Container(
        margin: EdgeInsets.only(
          top: 32
        ),
        child: ImgTextDescMiniButton(
          image: 'assets/illustrations/il_empty_bantuan.png',
          title: 'Ups, Kosong',
          desc: 'Wah, sepertinya kamu belum pernah menyelesaikan bantuan dari customer, cek home untuk mencoba membantu customer',
          width: 280,
          btnTitle: 'Ke Home',
          onPressed: (){
            setPage(context, 'home');
            Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
          },
        ),
      );
    }

    Widget RightExist() {
      return Container(
        margin: EdgeInsets.only(
          top: 32,
          left: 24,
          right: 24
        ),
        child: Column(
          children: doneData.map((order) {
            return WeeklyItem(
              bantuan: order.bantuan!,
              onPress: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => HelperBantuanDetailDonePage(order),
                  )
                );
              },
              isHelper: true,
            );
          }).toList(),
        ),
      );
    }

    Widget RightContentRender() {
      return doneData.length > 0 ? RightExist() : RightEmpty();
    }

    Widget ToggledContentRender() {
      return currentToggle == 'left' ? LeftContentRender() : RightContentRender();
    }

    Widget LoadingContent() {
      return Container(
        color: black.withOpacity(0.5),
        child: LoadingCustom(
          title: 'Loading . . .',
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
                MainHeader(
                  title: 'Dashboard Helper',
                  onBack: (){
                    Navigator.pop(context);
                  },
                  rightContent: ImageCustom(
                    width: 17,
                    height: 20,
                    image: AssetImage('assets/icons/ic_notif_chat.png'),
                  ),
                  onRightPress: () {
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 12
                    ),
                    children: [
                      HelperBM(),
                      SizedBox(height: 32,),
                      Line(),
                      SizedBox(height: 24,),
                      HelperInsightContent(),
                      ContentToggler(),
                      ToggledContentRender(),
                      SizedBox(height: 120,)
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
}