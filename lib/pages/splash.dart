import 'dart:async';
import 'dart:convert';

import 'package:bantuin/cubit/base_url_cubit.dart';
import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/modals/dialog_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var next = false;
  var showAsk = true;
  var change = false;
  TextEditingController baseUrlController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();

    check();
  }

  void check() async {
    var prefs = await SharedPreferences.getInstance();

    var baseUrl = prefs.get('baseurl');
    if (baseUrl != null) {
      setBaseUrl(context, baseUrl.toString());
    }

    if (next) {

      if (prefs.get('isLoggedIn') != null) {
        var userVm = UserViewModel(context);

        if (prefs.get('token') != null) {
          userVm.setToken(prefs.get('token').toString());
          var result = await userVm.fetch();

          if (result) {
            Timer(Duration(seconds: 2), (){
              Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
            });
          } else {
            Timer(Duration(seconds: 2), (){
              Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
            });
          }
        } else {
          Timer(Duration(seconds: 2), (){
            Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
          });
        }
      } else {
        if (prefs.getString('onboarding') != null) {
          Timer(Duration(seconds: 2), (){
            Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
          });
        } else {
          Timer(Duration(seconds: 2), (){
            Navigator.pushNamedAndRemoveUntil(context, '/get-started', (route) => false);
          });
        }
      }
    }
  }

  Widget BaseUrlDialog() {
    return showAsk ?
    DialogModal(
      children: [
        BlocBuilder<BaseUrlCubit, String>(
          builder: (context, baseUrl) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12
              ),
              child: Column(
                children: [
                  Text(
                    'Info',
                    style: mediumBlackSemibold,
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'Base url saat ini : ' + baseUrl + ", ingin mengganti?",
                    style: poppinsText.copyWith(
                      fontSize: 13,
                      fontWeight: regular,
                      color: black1
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RawButtonCustom(
                        height: 40,
                        onPress: () {
                          this.setState(() {
                            showAsk = false;
                            next = true;
                            check();
                          });
                        },
                        title: 'Gausah',
                        color: red1,
                      ),
                      SizedBox(width: 8,),
                      RawButtonCustom(
                        height: 40,
                        onPress: (){
                          this.setState(() {
                            showAsk = false;
                            change = true;
                            baseUrlController.text = baseUrl.toString();
                          });
                        },
                        title: 'Ganti',
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        )
      ],
    )
    : SizedBox();
  }

  Widget InputDialog() {
    return change ?
    DialogModal(
      children: [
        BlocBuilder<BaseUrlCubit, String>(
          builder: (context, baseUrl) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12
              ),
              child: Column(
                children: [
                  Text(
                    'Update Base Url Baru',
                    style: mediumBlackSemibold,
                  ),
                  SizedBox(height: 16,),
                  MainInputCustom(
                    controller: baseUrlController,
                    title: 'Url Baru',
                    hint: 'Masukkan base url baru',
                  ),
                  SizedBox(height: 16,),
                  MainButtonCustom(
                    title: 'Ganti',
                    onPressed: () {
                      if (baseUrlController.text == "") {
                        showGLobalAlert('danger', 'isi dulu cuy', context);
                      } else {
                        setBaseUrl(context, baseUrlController.text.toString());
                        setStringPref('baseurl', baseUrlController.text.toString());
          
                        this.setState(() {
                          change = false;
                          next = true;
                        });
          
                        check();
                      }
                    },
                  ),
                  SizedBox(height: 8,),
                  MainButtonCustom(
                    type: 'danger',
                    title: 'Batal',
                    onPressed: () {
                      this.setState(() {
                        change = false;
                        next = true;
                      });
          
                      check();
                    },
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            );
          },
        )
      ],
    )
    : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: green1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageCustom(
                    width: 120,
                    height: 120,
                    image: AssetImage('assets/images/logo.png'),
                    margin: EdgeInsets.only(
                      bottom: 16
                    ),
                  ),
                  Text(
                    'Bantuin',
                    style: poppinsText.copyWith(
                      fontSize: 32,
                      fontWeight: semiBold,
                      color: white
                    ),
                  )
                ],
              ),
            ),
          ),
          BaseUrlDialog(),
          InputDialog()
        ],
      ),
    );
  }
}