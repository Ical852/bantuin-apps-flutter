import 'dart:ffi';

import 'package:bantuin/shared/constants.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String formatter(int number) {
  var formatted = intl.NumberFormat.decimalPattern().format(number);

  return 'IDR. ' + formatted.replaceAll(',', '.');
}

Future<SharedPreferences> prefs() async {
  return await SharedPreferences.getInstance();
}

void setStringPref(key, value) async {
  var pref = await prefs();
  pref.setString(key, value);
}

String rawFormat(int number) {
  var formatted = intl.NumberFormat.decimalPattern().format(number);

  return formatted.replaceAll(',', '.');
}

double screenWidthPercentage(context, double percentage) {
  return MediaQuery.of(context).size.width * percentage;
}

double screenHeightPercentage(context, double percentage) {
  return MediaQuery.of(context).size.height * percentage;
}

Color getColorType(type) {
  if (type == 'danger') {
    return red1;
  } else if (type == 'info') {
    return blue1;
  } else {
    return green1;
  }
}

String getMonthName(month) {
  switch (month) {
    case 1 | 01:
      return 'Jan';
    case 2 | 02:
      return 'Feb';
    case 3 | 03:
      return 'Mar';
    case 4 | 04:
      return 'Apr';
    case 5 | 05:
      return 'May';
    case 6 | 06:
      return 'Jun';
    case 7 | 07:
      return 'Jul';
    case 8 | 08:
      return 'Aug';
    case 9 | 09:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return 'January';
  }
}

String getDayMonth(year, month, day) {
  DateTime newDate = DateTime(year, month, day);
  return newDate.day.toString() + " " + getMonthName(newDate.month);
}

void showGLobalAlert(type, text, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 2),
    content: Text(
      text,
      style: poppinsText.copyWith(
        fontSize: 14,
        color: white,
        fontWeight: bold
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: getColorType(type),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8)
      )
    ),
  ));
}

void showDrawer(BuildContext context, double height, Widget content) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32), 
        topRight: Radius.circular(32)
      )
    ),
    builder: (BuildContext context) {
      return Container(
        height: height ,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32)
          )
        ),
        child: content,
      );
    },
  );
}