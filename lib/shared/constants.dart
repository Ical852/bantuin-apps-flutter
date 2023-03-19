import 'package:bantuin/cubit/base_url_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

String getBaseUrl(BuildContext context) {
  return context.read<BaseUrlCubit>().state + "/api";
}

void setBaseUrl(BuildContext context, newUrl) {
  context.read<BaseUrlCubit>().setBaseUrl(newUrl);
}

const String google_api_key = "AIzaSyDABhwBawiYKTI63cP4xr1fUZmtXaP8iqI";

TextStyle poppinsText = GoogleFonts.poppins();

double safeAreaPadding(context) {
  return MediaQuery.of(context).padding.top;
}

double bottomSafeAreaPadding(context) {
  return MediaQuery.of(context).padding.bottom;
}

Color green1 = Color(0xff61B176);
Color green2 = Color(0xff79BD8A);
Color green3 = Color(0xffD7ECD9);
Color green4 = Color(0xff60C67A);
Color green5 = Color(0xffDCFFE4);
Color green6 = Color(0xffEBFFEB);
Color green7 = Color(0xffC8E5CB);
Color green8 = Color(0xffC1E4D4);
Color black1 = Color(0xff14491C);
Color black = Color(0xff000000);
Color grey1 = Color(0xff96A996);
Color grey2 = Color(0xffEEEEEE);
Color grey3 = Color(0xffF8F9FC);
Color grey4 = Color(0xffBAC7D5);
Color grey5 = Color(0xffEDF0ED);
Color grey6 = Color(0xffF5F5F5);
Color grey7 = Color(0xffFAFAFA);
Color yellow1 = Color(0xffEBBC6A);
Color yellow2 = Color(0xffEEC680);
Color red1 = Color(0xffE64848);
Color red2 = Color(0xffEA6363);
Color white = Color(0xffFFFFFF);
Color blue1 = Color(0xff509CE4);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight blackBold = FontWeight.w900;