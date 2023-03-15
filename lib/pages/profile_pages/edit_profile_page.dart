import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';
import 'package:bantuin/widgets/text_press.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController fullNameController = TextEditingController(text: "Shalahuddin Ahmad Aziz");
  TextEditingController usernameController = TextEditingController(text: "shalahuddin852");
  TextEditingController emailController = TextEditingController(text: "shalahuddin@gmail.com");
  TextEditingController phoneController = TextEditingController(text: "089756464773");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(
              title: 'Edit Profile',
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
                    image: AssetImage('assets/illustrations/il_edit_profile.png'),
                    margin: EdgeInsets.only(
                      bottom: 32
                    ),
                  ),
                  MainInputCustom(
                    controller: fullNameController,
                    hint: 'Masukkan Full Name',
                    title: 'Full Name',
                  ),
                  SizedBox(height: 20,),
                  MainInputCustom(
                    controller: usernameController,
                    hint: 'Masukkan Username',
                    title: 'Username',
                  ),
                  SizedBox(height: 20,),
                  MainInputCustom(
                    controller: emailController,
                    hint: 'Masukkan Email Address',
                    title: 'Email Address',
                    enabled: false,
                  ),
                  SizedBox(height: 20,),
                  MainInputCustom(
                    controller: phoneController,
                    hint: 'Masukkan Phone Number',
                    title: 'Phone Number',
                  ),
                  SizedBox(height: 32,),
                  MainButtonCustom(
                    title: 'Simpan',
                    onPressed: (){},
                  ),
                  SizedBox(height: 24,),
                  TextPress(
                    text: 'Ganti password? ',
                    pressText: 'Disini!',
                    onPress: (){
                      Navigator.pushNamed(context, '/change-pw');
                    },
                  ),
                  SizedBox(height: 120,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}