import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
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
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();

  TextEditingController fullNameController = TextEditingController(text: "");
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");

  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  @override
  void initState() {
    super.initState();

    this.setState(() {
      fullNameController.text = user.fullName;
      usernameController.text = user.username;
      emailController.text = user.email;
      phoneController.text = user.phoneNumber;
    });
  }

  void updateProfile() async {
    toggleLoading(true);
    var result = await userVm.userUpdate(
      fullName: fullNameController.text,
      username: usernameController.text,
      phoneNumber: phoneController.text
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
                        onPressed: (){
                          updateProfile();
                        },
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