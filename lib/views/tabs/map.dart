import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo>
    with AutomaticKeepAliveClientMixin<MapsDemo> {
  GoogleMapController mapController;
  Map<String, double> currentLocation;

  StreamSubscription<Map<String, double>> locationSubscription;

  Location location = new Location();
  bool permission = false;
  String error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();

    locationSubscription =
        location.onLocationChanged().listen((Map<String, double> result) {
      currentLocation = result;
      changeCameraPosition(
          LatLng(currentLocation['latitude'], currentLocation['longitude']));
    });
  }

  initPlatformState() async {
    try {
      permission = await location.hasPermission();
      currentLocation = await location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }
      currentLocation = null;
    }
    if (currentLocation != null) {
      changeCameraPosition(
          LatLng(currentLocation['latitude'], currentLocation['longitude']));
    }
  }

  changeCameraPosition(LatLng target) {
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          target: target,
          tilt: 30.0,
          zoom: 17.0,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 300.0,
              height: 300.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
              ),
            ),
          ),
          RaisedButton(
            child: const Text('Go to London'),
            onPressed: mapController == null
                ? null
                : () {
                    changeCameraPosition(LatLng(51.5160895, -0.1294527));
                  },
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
