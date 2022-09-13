import 'dart:async';
import 'dart:math';
import 'package:boka_fix/widgets/customButton.dart';
import 'package:boka_fix/widgets/locationListDialoge.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor mapMarker;
  List<String> lat = [];
  List<String> lng = [];

  Future<Position> currentCoordinates() async {
    return await Geolocator.getCurrentPosition();
  }

  randomPostion() async {
    final random = Random();
    double rLat = -90 + random.nextDouble() * 90 * 2;
    double rLng = -180 + random.nextDouble() * 180 * 2;

    markers.add(Marker(
      icon: mapMarker,
      markerId: MarkerId('1'),
      position: LatLng(rLat, rLng),
    ));
    CameraPosition cameraPosition =
        CameraPosition(zoom: 14, target: LatLng(rLat, rLng));

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
    lat.add(rLat.toStringAsFixed(2));
    lng.add(rLng.toStringAsFixed(2));
  }

  static const CameraPosition camPos =
      CameraPosition(target: LatLng(30.4, 143), zoom: 10);

  void customMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/mapMarker.png');
  }

  locationList() {
    return lat.isNotEmpty
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return locationListDialog(
                lat: lat,
                long: lng,
              );
            })
        : showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Coordinates Empty'),
                content: Text('No location have been selected yet'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
  }



  @override
  void initState() {
    customMarker();
    super.initState();
  }

  List<Marker> markers = <Marker>[
    Marker(
        zIndex: 2,
        markerId: MarkerId('1'),
        position: LatLng(30.4, 143),
        infoWindow: InfoWindow(title: "Current Position"))
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          buildGoogleMap(size),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              margin: EdgeInsets.only(),
              width: size.width * 0.9,
              height: size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: CustomButton(
                        buttonColor: Colors.lightBlueAccent,
                        buttonText: 'Random Location'),
                    onTap: randomPostion,
                  ),
                  GestureDetector(
                    child: CustomButton(
                        buttonColor: Colors.purple,
                        buttonText: 'Current Location'),
                    onTap: () async {
                      currentCoordinates().then((value) async {
                        lat.add(value.latitude.toStringAsFixed(2));
                        lng.add(value.longitude.toStringAsFixed(2));
                        markers.add(Marker(
                          icon: mapMarker,
                          markerId: MarkerId('1'),
                          position: LatLng(value.latitude, value.longitude),
                        ));
                        CameraPosition cameraPosition = CameraPosition(
                            zoom: 14,
                            target: LatLng(value.latitude, value.longitude));

                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(cameraPosition));
                        setState(() {});
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: size.height * 0.1,
              right: 10,
              child: GestureDetector(
                child: Container(
                  color: Colors.white,
                  child: Icon(
                    Icons.crop_free,
                    size: 40,
                  ),
                ),
                onTap: locationList,
              )),
        ],
      ),
    );
  }

  GoogleMap buildGoogleMap(Size size) {
    return GoogleMap(
      padding: EdgeInsets.only(bottom: size.height * 0.4),
      initialCameraPosition: camPos,
      markers: Set<Marker>.of(markers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
