import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              ImageCustom(
                width: 250,
                height: 250,
                image: AssetImage('assets/illustrations/il_welcome.png'),
              )
            ],
          ),
        ),
      ),      
    );
  }
}