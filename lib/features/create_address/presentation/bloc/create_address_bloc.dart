import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/geolocator/geolocator.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/create_address/domain/models/create_address_result.dart';
import 'package:muaho/features/create_address/domain/use_case/create_address_use_case.dart';

part 'create_address_event.dart';
part 'create_address_state.dart';

class _RequestCurrentLocation extends CreateAddressEvent {
  List<Object?> get props => [];
}

class CreateAddressBloc extends Bloc<CreateAddressEvent, CreateAddressState> {
  final AppGeoLocator appGeoLocator;
  final CreateAddressUseCase createAddressUseCase;
  String _address = "";
  String _contactPhone = "";
  double _lat = 0;
  double _lng = 0;
  RegExp regExp = new RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b');

  CreateAddressBloc({
    required this.appGeoLocator,
    required this.createAddressUseCase,
  }) : super(CreateAddressInitial()) {
    on<RequestLocation>(
      (event, emit) async {
        bool serviceEnabled = await appGeoLocator.isLocationEnable();
        if (!serviceEnabled) {
          emit(LocationDisable());
        } else {
          LocationPermissionApp permission =
              await appGeoLocator.requestPermission();

          if (permission == LocationPermissionApp.denied) {
            emit(LocationPermissionDenied());
          } else if (permission == LocationPermissionApp.deniedForever) {
            emit(LocationPermissionDeniedForever());
          } else {
            this.add(_RequestCurrentLocation());
          }
        }
      },
    );

    on<_RequestCurrentLocation>((event, emit) async {
      AppPosition? position = await appGeoLocator.getCurrentPosition();
      if (position != null) {
        await _handleLocationUpdate(emit,
            lat: position.latitude, lng: position.longitude);
      } else {
        //todo handle get position fail
      }
    });

    on<PickLocationEvent>(
      (event, emit) async {
        await _handleLocationUpdate(emit, lat: event.lat, lng: event.lng);
      },
      // transformer: (event, mapper) {
      //   return event.debounceTime(const Duration(milliseconds: 300));
      // },
    );

    on<TextingAddress>(
      (event, emit) {
        _address = event.value;
        if (_address.isEmpty) {
          emit(FailRequestAddressState());
        } else {
          emit(RequestAddressManualState());
        }
      },
    );

    on<TextingPhone>((event, emit) async {
      _contactPhone = event.value;
      emit(TextingPhoneNumberState());
      if (!regExp.hasMatch(_contactPhone) || _contactPhone.isEmpty) {
        emit(PhoneNumberNotValidated());
      } else {
        emit(PhoneNumberValidated());
      }
    });

    on<SubmitCreateAddress>((event, emit) async {
      if (_address.isEmpty) {
        emit(AddressEmpty());
      } else if (_contactPhone.isEmpty) {
        emit(PhoneEmpty());
      } else {
        Either<Failure, CreateAddressResult> result =
            await createAddressUseCase.execute(
          AddressInfoEntity(
            id: -1,
            contactPhoneNumber: _contactPhone,
            address: _address,
            lat: _lat,
            lng: _lng,
          ),
        );
        emit(CreatingAddress());
        Future.delayed(Duration(milliseconds: 2000));
        if (result.isSuccess) {
          emit(CreateAddressSuccess());
        } else {
          emit(CreateAddressFail());
        }
      }
    });
  }

  Future _handleLocationUpdate(
    Emitter<CreateAddressState> emit, {
    required double lat,
    required double lng,
  }) async {
    _lat = lat;
    _lng = lng;
    emit(LocationUpdateState(lat: _lat, lng: _lng));
    int startTime = DateTime.now().millisecondsSinceEpoch;
    emit(RequestingAddressState());
    List<Place>? places = await appGeoLocator.getPlaces(lat, lng);
    int requestAddressTime = DateTime.now().millisecondsSinceEpoch - startTime;
    int duration = 2000;
    var remainingTime = duration - requestAddressTime;
    if (remainingTime > 0) {
      await Future.delayed(Duration(milliseconds: remainingTime));
    }
    if (places != null && places.isNotEmpty) {
      _address = places.first.street;
      emit(
        AddressUpdateState(
          address: _address,
        ),
      );
    } else {
      emit(FailRequestAddressState());
    }
  }

  @override
  void onChange(Change<CreateAddressState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
