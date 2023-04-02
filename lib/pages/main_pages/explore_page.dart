import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/pages/detail_pages/bantuan_detail_pages.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/bantuan_view_model.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/main_items/special_item.dart';
import 'package:bantuin/widgets/main_items/weekly_item.dart';
import 'package:bantuin/widgets/title_descs/main_title_desc.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late var bantuanVm = BantuanViewModel(context);
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();

  List<BantuanModel> specials = [];
  var spcLoading = false;
  void toggleSpcLoading(value) {
    this.setState(() {
      spcLoading = value;
    });
  }
  void getSpcBantuan() async {
    toggleSpcLoading(true);
    var result = await bantuanVm.getSpecialBantuan();
    toggleSpcLoading(false);

    this.setState(() {
      specials = result;
    });
  }

  List<BantuanModel> weeklies = [];
  var weeklyLoading = false;
  void toggleWeekliesLoading(value) {
    this.setState(() {
      weeklyLoading = value;
    });
  }
  void getWeeklyBantuan() async {
    toggleWeekliesLoading(true);
    var result = await bantuanVm.getOldBantuan();
    toggleWeekliesLoading(false);

    this.setState(() {
      weeklies = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getSpcBantuan();
    getWeeklyBantuan();
  }

  @override
  Widget build(BuildContext context) {

    Widget HeaderBackground() {
      return Container(
        color: green1,
        height: 120 + safeAreaPadding(context),
      );
    }

    Widget SearchBar() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: 16
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12
          ),
          height: 40,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/bantuan-search');
            },
            child: Row(
              children: [
                ImageCustom(
                  height: 20,
                  width: 20,
                  image: AssetImage('assets/icons/ic_search_green.png'),
                  margin: EdgeInsets.only(
                    right: 12
                  ),
                ),
                Text(
                  'Explore campaigns',
                  style: regularGrayRegular
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget NotifButton() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: white
        ),
        width: 40,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent.withOpacity(0.1),
            padding: EdgeInsets.all(0)
          ),
          onPressed: (){
            Navigator.pushNamed(context, '/notifications');
          },
          child: Center(
            child: ImageCustom(
              height: 17,
              width: 15,
              image: AssetImage('assets/icons/ic_notif_green.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget HeaderContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 24 + safeAreaPadding(context),
          left: 24,
          right: 24
        ),
        child: Column(
          children: [
            Row(
              children: [
                SearchBar(),
                NotifButton()
              ],
            ),
            SizedBox(height: 14,),
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

    Widget ExploreTitleDesc(title, desc) {
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
    
    Widget ExploreEmpty() {
      return Container(
        margin: EdgeInsets.only(
          top: 16,
          bottom: 20,
          right: 16
        ),
        height: 270,
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              ImageCustom(
                image: AssetImage('assets/illustrations/il_empty_bantuan.png'),
                width: double.infinity,
                height: 270,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );
    }

    Widget ExistSpecial() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 24,),
            Row(
              children: specials.map((bantuan) {
                return SpecialItem(
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
            SizedBox(width: 8,),
          ],
        ),
      );
    }

    Widget LoadingExplore() {
      return Container(
        margin: EdgeInsets.only(
          top: 16,
          bottom: 20,
          right: 16
        ),
        height: 270,
        width: double.infinity,
        child: Center(
          child: LoadingCustom(
            title: '',
          ),
        ),
      );
    }

    Widget RenderSpecialContent() {
      return spcLoading ? LoadingExplore() : specials.length > 0 ? ExistSpecial() : ExploreEmpty();
    }

    Widget SpecialSection() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExploreTitleDesc('Spesial Bersih - Bersih', 'Khusus untuk kamu yang hobi bersih - bersih'),
            RenderSpecialContent()
          ],
        ),
      );
    }

    Widget ExistWeekly() {
      return Container(
        margin: EdgeInsets.only(
          top: 16,
          left: 24,
          right: 24
        ),
        child: Column(
          children: weeklies.map((bantuan) {
            return WeeklyItem(
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
      );
    }

    Widget RenderWeeklyContent() {
      return weeklyLoading ? LoadingExplore() : weeklies.length > 0 ? ExistWeekly() : ExploreEmpty();
    }

    Widget WeeklySection() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExploreTitleDesc('Bantuan 1 Minggu Terakhir', 'Temukan bantuan terbaru, customer butuh kamu!'),
            RenderWeeklyContent()
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
            SpecialSection(),
            WeeklySection(),
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
          MainContent()
        ],
      ),
    );
  }
}