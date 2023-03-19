import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';
import 'package:bantuin/widgets/text_press.dart';
import 'package:bantuin/widgets/title_descs/auth_title_desc.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  late var userVm = UserViewModel(context);

  TextEditingController emailController = TextEditingController(text: "");
  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void reset() async {
    toggleLoading(true);
    var result = await userVm.reset(email: emailController.text);
    if (result) {
      Navigator.pushNamed(context, '/reset-success');
    }
    toggleLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 50
              ),
              children: [
                AuthTitleDesc(
                  title: 'Reset Password',
                  desc: 'Kirimkan email kamu',
                ),
                ImageCustom(
                  height: 250,
                  width: 250,
                  image: AssetImage('assets/illustrations/il_reset.png'),
                  margin: EdgeInsets.symmetric(
                    vertical: 30
                  ),
                ),
                MainInputCustom(
                  controller: emailController,
                  title: 'Email Address',
                  hint: 'Masukkan Email',
                ),
                SizedBox(height: 24,),
                MainButtonCustom(
                  onPressed: (){
                    reset();
                  },
                  title: 'Kirim Email',
                ),
                SizedBox(height: 24,),
                TextPress(
                  text: 'Belum pernah memiliki akun? ',
                  pressText: 'Daftar!',
                  onPress: (){
                    Navigator.pushNamed(context, '/sign-up');
                  },
                ),
                SizedBox(height: 8,),
                TextPress(
                  text: 'Sudah pernah memiliki akun? ',
                  pressText: 'Masuk!',
                  onPress: (){
                    Navigator.pushNamed(context, '/sign-in');
                  },
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
                      'Requesting...',
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