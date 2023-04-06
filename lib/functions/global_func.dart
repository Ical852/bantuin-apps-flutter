import 'dart:ffi';

import 'package:bantuin/shared/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

String formatter(int number) {
  var formatted = intl.NumberFormat.decimalPattern().format(number);

  return 'IDR. ' + formatted.replaceAll(',', '.');
}

Future getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location Unable");
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permissions are denied");
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        "Location permissions are permanently denied, we cannot continue your request");
  }
  var geo = await Geolocator.getCurrentPosition();
  var locationLatLng = LatLng(geo.latitude, geo.longitude);
  return locationLatLng;
}

Future<SharedPreferences> prefs() async {
  return await SharedPreferences.getInstance();
}

Map<String, int> getDate(data) {
  var split = data.createdAt.split(data.createdAt[10]);
  var date = split[0];
  var format = date.split("-");

  return {
    "year": int.parse(date[0]),
    "month": int.parse(date[1]),
    "day": int.parse(date[2])
  };
}

void setStringPref(key, value) async {
  var pref = await prefs();
  pref.setString(key, value);
}

void removeStringPref(key) async {
  var pref = await prefs();
  pref.remove(key);
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

void goToGoogleMaps(currentLocation) async {
  var current = currentLocation;
  LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100
  );
  Geolocator.getPositionStream(locationSettings: locationSettings)
    .listen((Position position) {
      current = LatLng(position.latitude, position.longitude);
    });
  String googleUrl = "https://www.google.com/maps/search/?api=1&query=${current.latitude},${current.longitude}";
  await canLaunchUrlString(googleUrl) ? await launchUrlString(googleUrl) : throw 'Error';
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