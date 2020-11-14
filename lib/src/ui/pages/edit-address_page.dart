import 'dart:async';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/services/location_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditAddressPage extends StatefulWidget {
  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kMultan = CameraPosition(
    target: LatLng(30.1853239, 71.444964),
    zoom: 14.4746,
  );

  Future<void> _goToCurrentLocation() async {
    CurrentLocation location = CurrentLocation();
    // await location.getCurrentLocation();
    LatLng latLng = LatLng(location.latitude, location.longitude);
    await _moveToLocation(latLng);
  }

  final Set<Marker> _markers = {};

  _moveToLocation(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: latLng,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          draggable: true,
          onDragEnd: (newLatLng) => setState(() => latLng = newLatLng),
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          infoWindow: InfoWindow(
            title: 'Your Current Location',
            snippet: 'Drag and move marker to change location',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Address',
          style: kAppBarStyle,
        ),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: TextStyle(color: kMainColor, fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kMultan,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
          child: FloatingActionButton.extended(
            onPressed: _goToCurrentLocation,
            label: Text('Current Location'),
            icon: Icon(Icons.my_location_sharp),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
