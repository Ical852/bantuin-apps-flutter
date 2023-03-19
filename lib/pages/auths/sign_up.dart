import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
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

  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void signUp(context) async {
    var userVm = UserViewModel(context);

    toggleLoading(true);
    var result = await userVm.signUp(
      fullName: fullNameController.text,
      username: usernameController.text,
      phoneNumber: phoneNumberController.text,
      email: emailController.text,
      password: passwordController.text
    );
    toggleLoading(false);
    
    if (result) {
      Navigator.pushNamed(context, '/signup-success');
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
                    signUp(context);
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
                      'Signin Up...',
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