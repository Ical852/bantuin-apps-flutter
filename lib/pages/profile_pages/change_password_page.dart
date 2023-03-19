import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();

  TextEditingController curpwController = TextEditingController(text: "");
  TextEditingController newpwController = TextEditingController(text: "");
  TextEditingController confirmpwController = TextEditingController(text: "");

  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void updatePassword() async {
    toggleLoading(true);
    var result = await userVm.updatePassword(
      currentPassword: curpwController.text,
      newPassword: newpwController.text,
      confirmPassword: confirmpwController.text
    );
    toggleLoading(false);
    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                MainHeader(
                  title: 'Ganti Password',
                  onBack: (){
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 32,
                      left: 32,
                      right: 32
                    ),
                    children: [
                      ImageCustom(
                        height: 200,
                        width: 200,
                        image: AssetImage('assets/illustrations/il_changepw.png'),
                        margin: EdgeInsets.only(
                          bottom: 32
                        ),
                      ),
                      MainInputCustom(
                        controller: curpwController,
                        hint: 'Masukkan Current Password',
                        title: 'Current Password',
                        password: true,
                      ),
                      SizedBox(height: 20,),
                      MainInputCustom(
                        controller: newpwController,
                        hint: 'Masukkan New Password',
                        title: 'New Password',
                        password: true,
                      ),
                      SizedBox(height: 20,),
                      MainInputCustom(
                        controller: confirmpwController,
                        hint: 'Masukkan Confirm New Password',
                        title: 'Confirm New Password',
                        password: true,
                      ),
                      SizedBox(height: 32,),
                      MainButtonCustom(
                        title: 'Simpan',
                        onPressed: (){
                          updatePassword();
                        },
                      ),
                      SizedBox(height: 120,)
                    ],
                  ),
                )
              ],
            ),
            loading ? 
            Container(
              color: black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: white,
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'Updatting...',
                      style: baseWhiteSemibold,
                    )
                  ],
                ),
              ),
            )
            :
            SizedBox()
          ],
        ),
      ),
    );
  }
}