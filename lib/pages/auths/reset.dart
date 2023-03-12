import 'package:bantuin/shared/constants.dart';
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
  TextEditingController emailController = TextEditingController(text: "");
  
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
                Navigator.pushNamed(context, '/reset-success');
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
      ),
    );
  }
}