import 'dart:async';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyBantuanOnGoingMapPage extends StatefulWidget {
  @override
  State<MyBantuanOnGoingMapPage> createState() => _MyBantuanOnGoingMapPageState();

  UserModel helper;
  LatLng location;
  MyBantuanOnGoingMapPage(this.helper, this.location);
}

class _MyBantuanOnGoingMapPageState extends State<MyBantuanOnGoingMapPage> {
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();
  var updating = true;

  late var currentImage = user.image;
  var currentAddress = "";
  
  void getCurrentLocation() async {
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
      return Future.error("Location permissions are permanently denied, we cannot continue your request");
    }

    var geo = await Geolocator.getCurrentPosition();
    this.setState(() {
      currentLocation = LatLng(geo.latitude, geo.longitude);
    });
    getCurrentAddress(LatLng(geo.latitude, geo.longitude));
  }

  void getCurrentAddress(LatLng location) async {
    List<Placemark> placemakrs = await placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark place = placemakrs[0];
    this.setState(() {
      currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    });
  }

  late LatLng? currentLocation = null;
  late LatLng? helperLocation = null;
  late List<LatLng> coordinates = [helperLocation!, this.widget.location];

  void periodicUpdate() async {
    var timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      if (updating == false) {
        timer.cancel();
      }

      var collection = FirebaseFirestore.instance.collection('location_${this.widget.helper.id}');
      var check = await collection.get();
      if (check.docs.length > 0) {
        var doc = check.docs[0].data();
        String location = doc['location'];
        var splitted = location.split('|');
        print(splitted);
        this.setState(() {
          helperLocation = LatLng(double.parse(splitted[1]), double.parse(splitted[0]));
          coordinates = [LatLng(double.parse(splitted[1]), double.parse(splitted[0])), this.widget.location];
        });
      }
      print('Current ' + currentLocation.toString());
      print('Helper ' + helperLocation.toString());
      print('Target' +  this.widget.location.toString());
      getCurrentLocation();
    });
    
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    periodicUpdate();
  }

  Widget GmapBottomContent() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        width: screenWidthPercentage(context, 0.5),
        height: 120,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30)
          )
        ),
        child: Column(
          children: [
            Text(
              'Tekan Marker Untuk Melihat Detail',
              style: regularBlackSemibold,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            RawButtonCustom(
              height: 40,
              onPress: (){
                this.setState(() {
                  Navigator.pop(context);
                  updating = false;
                });
              },
              title: 'Kembali',
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation != null && helperLocation != null ? Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: helperLocation!,
                zoom: 14.5,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: coordinates,
                  color: Colors.blue,
                  width: 6
                )
              },
              markers: {
                Marker(
                    markerId: MarkerId("source"),
                    position: currentLocation!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure
                    ),
                    onTap: (){
                      this.setState(() {
                        currentImage = user.image;
                        getCurrentAddress(currentLocation!);
                      });
                    }
                ),
                Marker(
                    markerId: MarkerId("destination"), 
                    position: this.widget.location,
                    onTap: (){
                      this.setState(() {
                        currentImage = user.image;
                        getCurrentAddress(this.widget.location);
                      });
                    }
                ),
                Marker(
                  markerId: MarkerId("helper"), 
                  position: helperLocation!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueCyan
                    ),
                  onTap: (){
                    this.setState(() {
                        currentImage = this.widget.helper.image;
                        getCurrentAddress(helperLocation!);
                      });
                  }
                ),
              },
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCustom(
                    height: 60, width: 60,
                    network: true,
                    nwUrl: currentImage,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        currentAddress,
                        style: regularBlackRegular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GmapBottomContent()
          ],
        ),
      )
    ) : Scaffold(
      body: SafeArea(
        child: Container(
          color: black.withOpacity(0.5),
          child: Center(
            child: LoadingCustom(
              title: 'Loading . . .',
              isWhite: true,
            ),
          ),
        ),
      ),
    );
  }
}