import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muaho/common/extensions/ui/inject.dart';
import 'package:muaho/common/localization/app_localization.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/presentation/address/create_address/bloc/create_address_bloc.dart';

class CreateAddressScreen extends StatelessWidget {
  CreateAddressScreen({Key? key}) : super(key: key);
  static final String routeName = 'CreateAddressScreen';
  final Completer<GoogleMapController> _mapController = Completer();
  final TextEditingController _addressTextEditingController =
      TextEditingController(text: "");
  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    EdgeInsets safePadding = MediaQuery.of(context).padding;
    return BlocProvider<CreateAddressBloc>(
      create: (context) => inject()..add(RequestLocation()),
      child: BlocListener<CreateAddressBloc, CreateAddressState>(
        listener: (context, state) async {
          if (state is LocationUpdateState) {
            final GoogleMapController controller = await _mapController.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(state.lat, state.lng),
                  zoom: 16.5,
                ),
              ),
            );
          } else if (state is AddressUpdateState) {
            _addressTextEditingController.text = state.address;
          } else if (state is AddressEmpty) {
            _snakeBarBuilder(
                context, LocaleKeys.createAddress_invalidAddress.translate());
          } else if (state is PhoneEmpty) {
            _snakeBarBuilder(
                context, LocaleKeys.createAddress_invalidPhone.translate());
          } else if (state is CreatingAddress) {
            _showWaiting(context);
          } else if (state is CreateAddressSuccess) {
            Navigator.pop(context);
            Navigator.pop(context, true);
          } else if (state is CreateAddressFail) {
            _snakeBarBuilder(
                context, LocaleKeys.createAddress_errorCreateFail.translate());
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          resizeToAvoidBottomInset: true,
          body: _bodyBuilder(safePadding),
        ),
      ),
    );
  }

  void _snakeBarBuilder(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        margin: const EdgeInsets.only(bottom: 100, left: 50, right: 50),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0x85444444),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.error_outline_outlined,
                color: Theme.of(context).backgroundColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Theme.of(context).backgroundColor),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _bodyBuilder(EdgeInsets safePadding) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Stack(
            children: [
              _mapBuilder(),
              Builder(builder: (context) {
                return _btnCurrentLocation(context);
              }),
              Builder(builder: (context) {
                return _btnBack(safePadding, context);
              })
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Builder(builder: (ctx) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _addressInput(ctx),
                _phoneInput(ctx),
                Expanded(
                  child: Align(
                    child: _doneBtn(ctx),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ],
            );
          }),
        )
      ],
    );
  }

  Widget _doneBtn(BuildContext ctx) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        BlocProvider.of<CreateAddressBloc>(ctx).add(SubmitCreateAddress());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        height: 65,
        width: double.infinity,
        child: Center(
          child: Text(
            LocaleKeys.createAddress_createAddressButton.translate(),
            style: Theme.of(ctx)
                .textTheme
                .headline1
                ?.copyWith(color: Theme.of(ctx).cardColor),
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(ctx).primaryColorLight,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _addressTextFieldSuffixBuilder(CreateAddressState state) {
    if (state is RequestingAddressState) {
      return Container(
        width: 24,
        height: 24,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.deepOrange,
          ),
        ),
      );
    } else if (state is FailRequestAddressState) {
      return Icon(
        Icons.error_outlined,
        color: Colors.red,
      );
    } else if (state is AddressUpdateState ||
        state is RequestAddressManualState) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _phoneTextFieldSuffixBuilder(CreateAddressState state) {
    if (state is TextingPhoneNumberState) {
      return Container(
        width: 24,
        height: 24,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.deepOrange,
          ),
        ),
      );
    } else if (state is PhoneNumberNotValidated) {
      return Icon(
        Icons.error_outlined,
        color: Colors.red,
      );
    } else if (state is PhoneNumberValidated) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Container _phoneInput(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: BlocBuilder<CreateAddressBloc, CreateAddressState>(
        buildWhen: (pre, curr) {
          return curr is TextingPhoneNumberState ||
              curr is PhoneNumberNotValidated ||
              curr is PhoneNumberValidated;
        },
        builder: (context, state) {
          bool suffixBuilder = state is PhoneNumberValidated ||
              state is PhoneNumberNotValidated ||
              state is TextingPhoneNumberState;
          return Stack(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  BlocProvider.of<CreateAddressBloc>(context).add(
                    TextingPhone(value: value),
                  );
                },
                controller: _phoneTextEditingController,
                decoration: InputDecoration(
                  suffixIcon: suffixBuilder
                      ? Padding(
                          padding: const EdgeInsets.only(right: 36),
                          child: GestureDetector(
                            onTap: () {
                              _phoneTextEditingController.clear();
                              BlocProvider.of<CreateAddressBloc>(context).add(
                                TextingPhone(value: ""),
                              );
                            },
                            child: Icon(
                              Icons.highlight_off_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.only(
                      right: 16, left: 8, top: 20, bottom: 20),
                  label: Text(
                      LocaleKeys.createAddress_inputPhoneTitle.translate()),
                  hintText: LocaleKeys.createAddress_inputPhoneHint.translate(),
                  labelStyle: Theme.of(context).textTheme.headline3,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorLight,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _phoneTextFieldSuffixBuilder(state),
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Container _addressInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: BlocBuilder<CreateAddressBloc, CreateAddressState>(
        buildWhen: (pre, curr) {
          return curr is RequestingAddressState ||
              curr is FailRequestAddressState ||
              curr is AddressUpdateState ||
              curr is RequestAddressManualState;
        },
        builder: (context, state) {
          bool suffixBuilder =
              state is AddressUpdateState || state is RequestAddressManualState;
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
                width: double.infinity,
                child: TextFormField(
                  onChanged: (value) {
                    BlocProvider.of<CreateAddressBloc>(context).add(
                      TextingAddress(value: value),
                    );
                  },
                  textAlignVertical: TextAlignVertical.center,
                  controller: _addressTextEditingController,
                  decoration: InputDecoration(
                    suffixIcon: suffixBuilder
                        ? Padding(
                            padding: const EdgeInsets.only(right: 36),
                            child: GestureDetector(
                              onTap: () {
                                _addressTextEditingController.clear();
                                BlocProvider.of<CreateAddressBloc>(context).add(
                                  TextingAddress(value: ""),
                                );
                              },
                              child: Icon(
                                Icons.highlight_off_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    label: Text(
                        LocaleKeys.createAddress_inputAddressTitle.translate()),
                    hintText: LocaleKeys.createAddress_creatingAddressTitle
                        .translate(),
                    labelStyle: Theme.of(context).textTheme.headline3,
                    contentPadding: const EdgeInsets.only(
                        right: 16, left: 8, top: 20, bottom: 20),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColorLight,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).cardColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _addressTextFieldSuffixBuilder(state),
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Positioned _btnBack(EdgeInsets safePadding, BuildContext context) {
    return Positioned(
      left: 10,
      top: safePadding.top,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
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
            BlocProvider.of<CreateAddressBloc>(context).add(RequestLocation());
          },
        ),
      ),
    );
  }

  Widget _mapBuilder() {
    CameraPosition position = CameraPosition(
        target: LatLng(10.710119572748113, 106.7094172442297), zoom: 16.5);
    Marker marker =
        Marker(markerId: MarkerId("current"), position: position.target);
    return BlocBuilder<CreateAddressBloc, CreateAddressState>(
      buildWhen: (pre, curr) => curr is LocationUpdateState,
      builder: (context, state) {
        if (state is LocationUpdateState) {
          marker = Marker(
              markerId: MarkerId("current"),
              position: LatLng(state.lat, state.lng));
        }
        return Container(
          child: GoogleMap(
            onMapCreated: (controller) {
              _mapController.complete(controller);
            },
            markers: {
              marker,
            },
            onTap: (LatLng target) {
              BlocProvider.of<CreateAddressBloc>(context).add(
                PickLocationEvent(
                  lat: target.latitude,
                  lng: target.longitude,
                ),
              );
            },
            zoomControlsEnabled: false,
            mapType: MapType.terrain,
            initialCameraPosition: position,
            myLocationEnabled: false,
          ),
        );
      },
    );
  }

  Future<dynamic> _showWaiting(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          LocaleKeys.createAddress_creatingAddressTitle.translate(),
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.createAddress_creatingAddress.translate(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
