import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';
import 'package:bantuin/widgets/text_press.dart';
import 'package:bantuin/widgets/title_descs/auth_title_desc.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 50
          ),
          children: [
            AuthTitleDesc(
              title: 'Masuk',
              desc: 'Masuk dan mulai membantu',
            ),
            ImageCustom(
              height: 250,
              width: 250,
              image: AssetImage('assets/illustrations/il_signin.png'),
              margin: EdgeInsets.symmetric(
                vertical: 30
              ),
            ),
            MainInputCustom(
              controller: emailController,
              title: 'Email Address',
              hint: 'Masukkan Email',
            ),
            SizedBox(height: 20,),
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
                  onTap: (){
                    Navigator.pushNamed(context, '/reset');
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 18
                    ),
                    child: Text(
                      'Lupa Password ?',
                      style: regularPrimarySemibold
                    ),
                  ),
                ),
              ],
            ),
            MainButtonCustom(
              onPressed: (){
                Navigator.pushNamed(context, '/welcome');
              },
              title: 'Masuk',
            ),
            SizedBox(height: 24,),
            TextPress(
              text: 'Belum pernah memiliki akun? ',
              pressText: 'Daftar!',
              onPress: (){
                Navigator.pushNamed(context, '/sign-up');
              },
            )
          ],
        ),
      ),
    );
  }
}