import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/common/extensions/string.dart';
import 'package:muaho/main.dart';
import 'package:muaho/presentation/address/create_address/bloc/create_address_bloc.dart';

class CreateAddressScreen extends StatelessWidget {
  CreateAddressScreen({Key? key}) : super(key: key);
  static final String routeName = 'CreateAddressScreen';
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    EdgeInsets safePadding = MediaQuery.of(context).padding;
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider<CreateAddressBloc>(
        create: (context) => getIt()..add(RequestPermission()),
        child: BlocBuilder<CreateAddressBloc, CreateAddressState>(
          builder: (ctx, state) {
            return _bodyBuilder(ctx, safePadding, state);
          },
        ),
      ),
    );
  }

  Widget _bodyBuilder(
      BuildContext context, EdgeInsets safePadding, CreateAddressState state) {
    if (state is GetCurrentLocationSuccess) {
      final CameraPosition position = CameraPosition(
        target: LatLng(state.addressTemp.lng.defaultZero(),
            state.addressTemp.lat.defaultZero()),
        zoom: 16.8,
      );
      return Column(
        children: [
          Flexible(
            flex: 1,
            child: Stack(
              children: [
                _mapBuilder(context, _controller, state, position),
                _btnCurrentLocation(context, position),
                _btnBack(safePadding, context)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Text("Địa chỉ giao hàng"),
                          hintText: "Muaho sẽ giao hàng ở địa chỉ này!",
                          labelStyle: Theme.of(context).textTheme.headline3,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorLight,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).backgroundColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                        initialValue: state.addressTemp.address.defaultEmpty(),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: Text("Số điện thoại"),
                          hintText: "0909xxxxxx",
                          labelStyle: Theme.of(context).textTheme.headline3,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorLight,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).backgroundColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
    } else if (state is CreateAddressInitial) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Text(state.toString()),
      );
    }
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

  Widget _btnCurrentLocation(BuildContext context, CameraPosition position) {
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
            controller.animateCamera(CameraUpdate.newCameraPosition(position));
          },
        ),
      ),
    );
  }

  Container _mapBuilder(
      BuildContext context,
      Completer<GoogleMapController> ctl,
      GetCurrentLocationSuccess state,
      CameraPosition position) {
    return Container(
      child: GoogleMap(
        onMapCreated: (controller) {
          ctl.complete(controller);
        },
        markers: {
          Marker(markerId: MarkerId("current"), position: position.target),
        },
        zoomControlsEnabled: false,
        mapType: MapType.terrain,
        initialCameraPosition: position,
        myLocationEnabled: false,
      ),
    );
  }
}
