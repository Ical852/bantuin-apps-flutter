import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

String baseUrl = "http://192.168.100.16:8000/api";
const String google_api_key = "AIzaSyDABhwBawiYKTI63cP4xr1fUZmtXaP8iqI";

String formatter(int number) {
  var formatted = intl.NumberFormat.decimalPattern().format(number);

  return formatted;
}

void showGLobalAlert(type, text, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 1),
    content: Text(
      text,
      style: poppinsText.copyWith(fontSize: 14, color: white, fontWeight: bold),
      textAlign: TextAlign.center,
    ),
    backgroundColor: type == 'danger' ? red1 : Color(0xff27BD48),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
  ));
}

TextStyle poppinsText = GoogleFonts.poppins();

Color green1 = Color(0xff61B176);
Color green2 = Color(0xff79BD8A);
Color green3 = Color(0xffD7ECD9);
Color black1 = Color(0xff14491C);
Color grey1 = Color(0xff96A996);
Color grey2 = Color(0xffEEEEEE);
Color yellow1 = Color(0xffEBBC6A);
Color yellow2 = Color(0xffEEC680);
Color red1 = Color(0xffE64848);
Color white = Color(0xffFFFFFF);
Color blue1 = Color(0xff509CE4);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight blackBold = FontWeight.w900;