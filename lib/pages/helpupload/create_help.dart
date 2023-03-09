import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:flutter/material.dart';

class CreateHelpPage extends StatefulWidget {
  @override
  State<CreateHelpPage> createState() => _CreateHelpPageState();
}

class _CreateHelpPageState extends State<CreateHelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              MainHeader(
                title: 'Cari Bantuan',
                onBack: (){
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: ListView(
                  children: [
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}