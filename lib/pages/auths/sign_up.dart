import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';
import 'package:bantuin/widgets/text_press.dart';
import 'package:bantuin/widgets/title_descs/auth_title_desc.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullNameController = TextEditingController(text: "");
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController phoneNumberController = TextEditingController(text: "");
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
              title: 'Daftar',
              desc: 'Daftar untuk mengakses aplikasi',
            ),
            ImageCustom(
              height: 250,
              width: 250,
              image: AssetImage('assets/illustrations/il_signup.png'),
              margin: EdgeInsets.symmetric(
                vertical: 30
              ),
            ),
            MainInputCustom(
              controller: fullNameController,
              title: 'Full Name',
              hint: 'Masukkan Nama',
            ),
            SizedBox(height: 20,),
            MainInputCustom(
              controller: usernameController,
              title: 'Username',
              hint: 'Masukkan Username',
            ),
            SizedBox(height: 20,),
            MainInputCustom(
              controller: emailController,
              title: 'Email Address',
              hint: 'Masukkan Email',
            ),
            SizedBox(height: 20,),
            MainInputCustom(
              controller: phoneNumberController,
              title: 'Phone Number',
              hint: 'Masukkan Nomor Telepon',
            ),
            SizedBox(height: 20,),
            MainInputCustom(
              controller: passwordController,
              title: 'Password',
              hint: 'Masukkan Password',
              password: true,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 18,
                bottom: 32
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Dengan mendaftar, anda setuju dengan ',
                      style: poppinsText.copyWith(
                        fontSize: 11,
                        fontWeight: regular,
                        color: black1
                      ),
                    ),
                    TextSpan(
                      text: 'Syarat & Ketentuan',
                      style: poppinsText.copyWith(
                        fontSize: 11,
                        fontWeight: semiBold,
                        color: green1
                      )
                    ),
                    TextSpan(
                      text: ' dan ',
                      style: poppinsText.copyWith(
                        fontSize: 11,
                        fontWeight: regular,
                        color: black1
                      )
                    ),
                    TextSpan(
                      text: 'Kebijakan Privasi',
                      style: poppinsText.copyWith(
                        fontSize: 11,
                        fontWeight: semiBold,
                        color: green1
                      )
                    ),
                    TextSpan(
                      text: ' kami',
                      style: poppinsText.copyWith(
                        fontSize: 11,
                        fontWeight: regular,
                        color: black1
                      )
                    ),
                  ],
                ),
              ),
            ),
            MainButtonCustom(
              onPressed: (){
                Navigator.pushNamed(context, '/signup-success');
              },
              title: 'Daftar',
            ),
            SizedBox(height: 24,),
            TextPress(
              text: 'Sudah pernah memiliki akun? ',
              pressText: 'Masuk!',
              onPress: (){
                Navigator.pushNamed(context, '/sign-in');
              },
            )
          ],
        ),
      ),
    );
  }
}