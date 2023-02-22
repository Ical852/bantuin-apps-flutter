import 'dart:async';
import 'dart:ffi';

import 'package:bantuin/shared/constatns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:geocoding/geocoding.dart';

class MapTestPage extends StatefulWidget {
  @override
  State<MapTestPage> createState() => _MapTestPageState();
}

class _MapTestPageState extends State<MapTestPage> {
  var currentLocation = null;
  var currentImage = "https://media.licdn.com/dms/image/D5603AQG8TnZ0oQ1E_A/profile-displayphoto-shrink_800_800/0/1671005717839?e=2147483647&v=beta&t=jFOOZ9g0fZGBzxaAicpzK8cZDdH7oGOhW0AuTkt7Wlw";

  void goToGoogleMaps() async {
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
        });
      });

    String googleUrl = "https://www.google.com/maps/search/?api=1&query=${currentLocation.latitude},${currentLocation.longitude}";
    await canLaunchUrlString(googleUrl) ? await launchUrlString(googleUrl) : throw 'Error';
  }

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
  }

  // LEARNING

  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  List<LatLng> coordinates = [sourceLocation, destination];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _getLocation();
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    List<Placemark> addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    var first = addresses.first;
    print("${first.name} : ${first..administrativeArea}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: sourceLocation,
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
                    position: sourceLocation,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure
                    ),
                    onTap: (){
                      this.setState(() {
                        currentImage = "https://media.licdn.com/dms/image/D5603AQG8TnZ0oQ1E_A/profile-displayphoto-shrink_800_800/0/1671005717839?e=2147483647&v=beta&t=jFOOZ9g0fZGBzxaAicpzK8cZDdH7oGOhW0AuTkt7Wlw";
                      });
                    }
                ),
                Marker(
                    markerId: MarkerId("destination"), 
                    position: destination,
                    onTap: (){
                      this.setState(() {
                        currentImage = "https://media.licdn.com/dms/image/D5603AQFxCtdgEqVzwQ/profile-displayphoto-shrink_200_200/0/1669243862530?e=1682553600&v=beta&t=dcmzZoMCOjo9nQ25a9TJXfjfBMICpQMXWONr9Rz_49Q";
                      });
                    }
                ),
              },
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(currentImage)
                )
              ),
            )
          ],
        ),
      )
    );
  }
}