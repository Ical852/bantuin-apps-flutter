import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/bm_contents/bantuan_money.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/profile_item.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();

  Function() openDrawer;
  ProfilePage(this.openDrawer);
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    Widget HeaderBackground() {
      return Container(
        height: 240,
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
          top: 48,
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
              style: poppinsText.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
                color: white
              ),
            ),
            ImageCustom(
              height: 20,
              width: 17,
              image: AssetImage('assets/icons/ic_notif_profile.png'),
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
            Container(
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
                image: AssetImage('assets/dummies/ava.png'),
                borderRadius: BorderRadius.circular(50),
                fit: BoxFit.cover,
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
                      'Shalahuddin Ahmad Aziz',
                      style: poppinsText.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                        color: white
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      'shalahuddin@gmail.com',
                      style: poppinsText.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                        color: white
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      'Customer & Helper',
                      style: poppinsText.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                        color: white
                      ),
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
                money: 9200301,
                onPress: (){},
              ),
            )
          ],
        ),
      );
    }

    Widget MainContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 306,
          left: 24,
          right: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Settings',
              style: poppinsText.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
                color: black1
              ),
            ),
            SizedBox(height: 16,),
            ProfileItem(
              icon: 'assets/icons/ic_edit.png',
              title: 'Edit Profile',
              desc: 'Edit data pribadi anda',
              width: 20,
              height: 20,
              onPress: (){},
            ),
            ProfileItem(
              icon: 'assets/icons/ic_dashboard.png',
              title: 'Helper Dashboard',
              desc: 'Insight anda sebagai helper',
              width: 20,
              height: 21,
              onPress: (){},
            ),
            ProfileItem(
              icon: 'assets/icons/ic_bantuan.png',
              title: 'Bantuan Anda',
              desc: 'Bantuan yang kamu publikasi',
              width: 24,
              height: 24,
              onPress: (){},
            ),
            ProfileItem(
              icon: 'assets/icons/ic_dollar.png',
              title: 'Transaksi Anda',
              desc: 'Semua transaksi anda',
              width: 12,
              height: 22,
              onPress: (){},
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