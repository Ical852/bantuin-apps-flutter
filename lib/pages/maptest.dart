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
  var currentImage = "";
  var currentAddress = "";

  var currentLocation = null;
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

  void getCurrentAddress(LatLng location) async {
    List<Placemark> placemakrs = await placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark place = placemakrs[0];
    this.setState(() {
      currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    });
  }

  // LEARNING

  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(-6.184361, 106.687516);
  static const LatLng destination = LatLng(-6.163399, 106.747720);
  List<LatLng> coordinates = [sourceLocation, destination];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
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
                        getCurrentAddress(sourceLocation);
                      });
                    }
                ),
                Marker(
                    markerId: MarkerId("destination"), 
                    position: destination,
                    onTap: (){
                      this.setState(() {
                        currentImage = "https://instagram.fcgk28-1.fna.fbcdn.net/v/t51.2885-19/323873537_2585500534926512_3899827331589008212_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fcgk28-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=20lbIhzulnQAX-_-mon&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfA4734DdEvvRvKVyXWiB56TM0gan0AZsUHDhRAPxUurIg&oe=64070027&_nc_sid=1527a3";
                        getCurrentAddress(destination);
                      });
                    }
                ),
              },
              
            ),
            Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(currentImage)
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        currentAddress,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}