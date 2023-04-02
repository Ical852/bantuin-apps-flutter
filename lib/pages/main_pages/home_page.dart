import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/pages/detail_pages/bantuan_detail_pages.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/bantuan_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money.dart';
import 'package:bantuin/widgets/buttons/mini_icon_button_custom.dart';
import 'package:bantuin/widgets/main_items/expensive_item.dart';
import 'package:bantuin/widgets/main_items/new_item.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

  Function() openDrawer;
  HomePage(this.openDrawer);
}

class _HomePageState extends State<HomePage> {
  late var bantuanVm = BantuanViewModel(context);
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();

  List<BantuanModel> exps = [];
  var expLoading = false;
  void toggleExpLoading(value) {
    this.setState(() {
      expLoading = value;
    });
  }
  void getExpBantuan() async {
    toggleExpLoading(true);
    var result = await bantuanVm.getExpensiveBantuan();
    toggleExpLoading(false);

    this.setState(() {
      exps = result;
    });
  }

  List<BantuanModel> news = [];
  var newLoading = false;
  void toggleNewLoading(value) {
    this.setState(() {
      newLoading = value;
    });
  }
  void getNewBantuan() async {
    toggleExpLoading(true);
    var result = await bantuanVm.getNewBantuan();
    toggleExpLoading(false);

    this.setState(() {
      news = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getExpBantuan();
    getNewBantuan();
  }

  @override
  Widget build(BuildContext context) {

    Widget HeaderBackground() {
      return Container(
        height: 125 + safeAreaPadding(context),
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
          top: 32 + safeAreaPadding(context),
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MiniIconButtonCustom(
                      onPressed: (){
                        this.widget.openDrawer();
                      },
                      icons: 'assets/icons/ic_bar.png',
                      width: 16,
                      height: 14,
                    ),
                    Container(width: 34,)
                  ],
                ),
                Text(
                  'Cari Bantuan',
                  style: regularWhiteSemibold
                ),
                Row(
                  children: [
                    MiniIconButtonCustom(
                      onPressed: (){
                        Navigator.pushNamed(context, '/bantuan-search');
                      },
                      icons: 'assets/icons/ic_search_home.png',
                      width: 18,
                      height: 18,
                    ),
                    SizedBox(width: 8,),
                    MiniIconButtonCustom(
                      onPressed: (){
                        Navigator.pushNamed(context, '/notifications');
                      },
                      icons: 'assets/icons/ic_notif.png',
                      width: 16,
                      height: 19,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 24,),
            BantuanMoney(
              money: user.balance,
              onPress: (){
                Navigator.pushNamed(context, '/top-up');
              },
            )
          ],
        ),
      );
    }

    Widget HomeTitleDesc(title, desc) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24
        ),
        child: MainTitleDesc(
          title: title,
          desc: desc,
        ),
      );
    }

    Widget EmptyExpensive() {
      return Container(
        margin: EdgeInsets.only(
          right: 24,
          top: 16,
          bottom: 20
        ),
        width: double.infinity,
        height: 350,
        child: Center(
          child: Column(
            children: [
              ImageCustom(
                image: AssetImage('assets/illustrations/il_empty_bantuan.png'),
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );
    }

    Widget ExistExpensive() {
      return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 24,),
              Row(
                children: exps.map((bantuan) {
                  return ExpensiveItem(
                    bantuan: bantuan,
                    onPress: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => BantuanDetailPage(bantuan)
                        )
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget LoadingExpensive() {
      return Container(
        margin: EdgeInsets.only(
          right: 24,
          top: 16,
          bottom: 20
        ),
        width: double.infinity,
        height: 350,
        child: Center(
          child: LoadingCustom(
            title: '',
          ),
        ),
      );
    }

    Widget RenderExpensiveContent() {
      return expLoading ? LoadingExpensive() : exps.length > 0 ? ExistExpensive() : EmptyExpensive();
    }

    Widget ExpensiveSection() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTitleDesc('Bantuan Temahal', 'Temukan bantuan termahal dan dapatkan uangmu'),
            RenderExpensiveContent()
          ],
        ),
      );
    }

    Widget ExistNew() {
      return Container(
        child: Container(
          margin: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: news.map((bantuan) {
              return NewItem(
                bantuan: bantuan,
                onPress: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => BantuanDetailPage(bantuan)
                    )
                  );
                },
              );
            }).toList(),
          ),
        ),
      );
    }

    Widget EmptyNew() {
      return Container(
        margin: EdgeInsets.only(
          right: 24,
          top: 16,
          bottom: 20
        ),
        width: double.infinity,
        height: 350,
        child: Center(
          child: Column(
            children: [
              ImageCustom(
                image: AssetImage('assets/illustrations/il_empty_bantuan.png'),
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );
    }

    Widget LoadingNew() {
      return Container(
        margin: EdgeInsets.only(
          right: 24,
          top: 16,
          bottom: 20
        ),
        width: double.infinity,
        height: 350,
        child: Center(
          child: LoadingCustom(
            title: '',
          ),
        ),
      ); 
    }

    Widget RenderNewSection() {
      return newLoading ? LoadingNew() : news.length > 0 ? ExistNew() : EmptyNew();
    }

    Widget NewSection() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTitleDesc('Bantuan Terbaru', 'Temukan bantuan terbaru, customer butuh kamu!'),
            RenderNewSection()
          ],
        ),
      );
    }

    Widget MainContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 182 + safeAreaPadding(context)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpensiveSection(),
            NewSection(),
            SizedBox(height: 150,)
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Stack(
        children: [
          HeaderBackground(),
          HeaderContent(),
          MainContent(),
        ],
      ),
    );
  }
}