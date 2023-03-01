import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStarted extends StatefulWidget {
  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Temukan orang yang butuh bantuanmu",
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff14491C)
                ),
              ),
              SizedBox(height: 8,),
              Text(
                "temukan dan pilih orang yang membutuhkan bantuanmu, sesuaikan kebutuhan bayaran yang ingin kamu dapatkan dari peminta bantuan",
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff96A996)
                ),
              ),
              SizedBox(height: 32,),
              Container(
                margin: EdgeInsets.only(
                  bottom: 32
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff61B176),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}