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
  TextEditingController curpwController = TextEditingController(text: "");
  TextEditingController newpwController = TextEditingController(text: "");
  TextEditingController confirmpwController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                  ),
                  SizedBox(height: 20,),
                  MainInputCustom(
                    controller: newpwController,
                    hint: 'Masukkan New Password',
                    title: 'New Password',
                  ),
                  SizedBox(height: 20,),
                  MainInputCustom(
                    controller: confirmpwController,
                    hint: 'Masukkan Confirm New Password',
                    title: 'Confirm New Password',
                  ),
                  SizedBox(height: 32,),
                  MainButtonCustom(
                    title: 'Simpan',
                    onPressed: (){},
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