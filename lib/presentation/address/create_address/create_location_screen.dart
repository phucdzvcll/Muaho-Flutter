import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateAddressScreen extends StatelessWidget {
  CreateAddressScreen({Key? key}) : super(key: key);
  static final String routeName = 'CreateAddressScreen';
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.753793862399876, 106.70607183278857),
    zoom: 16.8,
  );
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    EdgeInsets safePadding = MediaQuery.of(context).padding;
    return new Scaffold(
      body: Stack(
        children: [
          _mapBuilder(context, _controller),
          _btnCurrentLocation(context),
          _btnBack(safePadding, context)
        ],
      ),
    );
  }

  Positioned _btnBack(EdgeInsets safePadding, BuildContext context) {
    return Positioned(
      left: 10,
      top: safePadding.top,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 1)),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _btnCurrentLocation(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 10,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: Theme.of(context).primaryColorLight, width: 0.5),
        ),
        child: IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(
            Icons.gps_fixed_outlined,
            size: 24,
            color: Colors.black,
          ),
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
          },
        ),
      ),
    );
  }

  Container _mapBuilder(
      BuildContext context, Completer<GoogleMapController> ctl) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: GoogleMap(
        onMapCreated: (controller) {
          ctl.complete(controller);
        },
        markers: {
          Marker(markerId: MarkerId("current"), position: _kGooglePlex.target),
        },
        zoomControlsEnabled: false,
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
      ),
    );
  }
}
