import 'package:bantuin/services/user_service.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';
import 'package:bantuin/widgets/text_press.dart';
import 'package:bantuin/widgets/title_descs/auth_title_desc.dart';
import 'package:flutter/material.dart';

import '../../view_models/user_view_model.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void signIn(context) async {
    var userVm = UserViewModel(context);

    toggleLoading(true);
    var result = await userVm.signIn(
      email: emailController.text,
      password: passwordController.text
    );
    toggleLoading(false);

    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 50),
              children: [
                AuthTitleDesc(
                  title: 'Masuk',
                  desc: 'Masuk dan mulai membantu',
                ),
                ImageCustom(
                  height: 250,
                  width: 250,
                  image: AssetImage('assets/illustrations/il_signin.png'),
                  margin: EdgeInsets.symmetric(vertical: 30),
                ),
                MainInputCustom(
                  controller: emailController,
                  title: 'Email Address',
                  hint: 'Masukkan Email',
                ),
                SizedBox(
                  height: 20,
                ),
                MainInputCustom(
                  controller: passwordController,
                  title: 'Password',
                  hint: 'Masukkan Password',
                  password: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/reset');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 18),
                        child: Text('Lupa Password ?',
                            style: regularPrimarySemibold),
                      ),
                    ),
                  ],
                ),
                MainButtonCustom(
                  onPressed: () {
                    signIn(context);
                  },
                  title: 'Masuk',
                ),
                SizedBox(
                  height: 24,
                ),
                TextPress(
                  text: 'Belum pernah memiliki akun? ',
                  pressText: 'Daftar!',
                  onPress: () {
                    Navigator.pushNamed(context, '/sign-up');
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
                      'Signin In...',
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