import 'dart:async';
import 'dart:io';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/pages/helper_pages/helper_dashboard.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/img_text_btn/img_desc_btn.dart';
import 'package:bantuin/widgets/modals/image_picker_modal.dart';
import 'package:bantuin/widgets/money_contents/bantuan_money.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();

  Function() openDrawer;
  ProfilePage(this.openDrawer);
}

class _ProfilePageState extends State<ProfilePage> {
  late var userVm = UserViewModel(context);
  late UserModel user = userVm.getUserData();

  var choosePickImage = false;
  void toggleChoose(value) {
    this.setState(() {
      choosePickImage = value;
    });
  }

  Future pickImage(ImageSource source) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return showGLobalAlert('danger', 'Batal Mengambil Gambar?', context);
      }
      File img = File(image.path);
      toggleChoose(false);
      var result = await userVm.updateAvatar(filePath: img.path);
      if (result) {
        this.setState(() {
          user = userVm.getUserData();
        });
      }
    } catch (e) {
      showGLobalAlert('danger', 'Terjadi Kesalahan, Coba Lagi Beberapa Saat', context);
    }
  }

  @override
  void initState() {
    super.initState();
    userVm.fetch();
  }

  @override
  Widget build(BuildContext context) {
    Widget ChooseImagePicker() {
      return choosePickImage ?
      ImagePickerModal(
        bgPress: () => toggleChoose(false),
        onLibrary: (){
          pickImage(ImageSource.gallery);
        },
        onCamera: (){
          pickImage(ImageSource.camera);
        },
      )
      :
      SizedBox();
    }

    Widget HeaderBackground() {
      return Container(
        height: 220 + safeAreaPadding(context),
        decoration: BoxDecoration(
          color: green1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30)
          )
        ),
      );
    }

    Widget TopContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 28 + safeAreaPadding(context),
          left: 24,
          right: 24
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                this.widget.openDrawer();
              },
              child: ImageCustom(
                height: 18,
                width: 18,
                image: AssetImage('assets/icons/ic_bar_profile.png'),
              ),
            ),
            Text(
              'My Profile',
              style: regularWhiteSemibold
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/notifications');
              },
              child: ImageCustom(
                height: 20,
                width: 17,
                image: AssetImage('assets/icons/ic_notif_profile.png'),
              ),
            )
          ],
        ),
      );
    }

    Widget ProfileContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => toggleChoose(true),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: ImageCustom(
                  margin: EdgeInsets.all(4),
                  height: 90,
                  width: 90,
                  borderRadius: BorderRadius.circular(50),
                  fit: BoxFit.cover,
                  network: true,
                  nwUrl: user.image,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: 12
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: mediumWhiteSemibold
                    ),
                    SizedBox(height: 4,),
                    Text(
                      user.email,
                      style: regularWhiteRegular
                    ),
                    SizedBox(height: 4,),
                    Text(
                      user.helper != null ? 'Customer & Helper' : 'Customer',
                      style: regularWhiteRegular
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget HeaderContent() {
      return Container(
        child: Column(
          children: [
            TopContent(),
            ProfileContent(),
            Container(
              margin: EdgeInsets.only(
                top: 16,
                left: 24,
                right: 24
              ),
              child: BantuanMoney(
                money: user.balance,
                onPress: (){
                  Navigator.pushNamed(context, '/top-up');
                },
              ),
            )
          ],
        ),
      );
    }

    Widget RequestHelperDrawer() {
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

    Widget MainContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 286 + safeAreaPadding(context),
          left: 24,
          right: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Settings',
              style: mediumBlackSemibold
            ),
            SizedBox(height: 16,),
            ProfileItem(
              icon: 'assets/icons/ic_edit.png',
              title: 'Edit Profile',
              desc: 'Edit data pribadi anda',
              width: 20,
              height: 20,
              onPress: (){
                Navigator.pushNamed(context, '/edit-profile');
              },
            ),
            ProfileItem(
              icon: 'assets/icons/ic_dashboard.png',
              title: 'Helper Dashboard',
              desc: 'Insight anda sebagai helper',
              width: 20,
              height: 21,
              onPress: (){
                if (user.helper == null) {
                  showDrawer(context, Platform.isIOS ? 418 : 398, RequestHelperDrawer());
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelperDashboardPage()
                    )
                  );
                }
              },
            ),
            ProfileItem(
              icon: 'assets/icons/ic_bantuan.png',
              title: 'Bantuan Anda',
              desc: 'Bantuan yang kamu publikasi',
              width: 24,
              height: 24,
              onPress: (){
                Navigator.pushNamed(context, '/my-bantuan');
              },
            ),
            ProfileItem(
              icon: 'assets/icons/ic_dollar.png',
              title: 'Transaksi Anda',
              desc: 'Semua transaksi anda',
              width: 12,
              height: 22,
              onPress: (){
                Navigator.pushNamed(context, '/transactions');
              },
            ),
            ProfileItem(
              icon: 'assets/icons/ic_ask.png',
              title: 'Help Center',
              desc: 'Jika anda butuh bantuan',
              width: 24,
              height: 24,
              onPress: (){},
            ),
            ProfileItem(
              icon: 'assets/icons/ic_settings.png',
              title: 'Settings',
              desc: 'Pengaturan aplikasi',
              width: 20,
              height: 20,
              onPress: (){},
            ),
            SizedBox(height: 150,)
          ],
        ),
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          child: Stack(
            children: [
              HeaderBackground(),
              HeaderContent(),
              MainContent(),
            ],
          ),
        ),
        ChooseImagePicker(),
      ],
    );
  }
}