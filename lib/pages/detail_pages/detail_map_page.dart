import 'dart:async';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailMapPage extends StatefulWidget {
  @override
  State<DetailMapPage> createState() => _DetailMapPageState();

  UserModel customer;
  LatLng location;
  DetailMapPage(this.customer, this.location);
}

class _DetailMapPageState extends State<DetailMapPage> {
  late var userVm = UserViewModel(context);
  late var user = userVm.getUserData();

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
  late List<LatLng> coordinates = [currentLocation!, this.widget.location];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
    return currentLocation != null ? Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
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
                        currentImage = this.widget.customer.image;
                        getCurrentAddress(this.widget.location);
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