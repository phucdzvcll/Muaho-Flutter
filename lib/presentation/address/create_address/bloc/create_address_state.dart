part of 'create_address_bloc.dart';

@immutable
abstract class CreateAddressState {}

class CreateAddressInitial extends CreateAddressState {}

class LocationDisable extends CreateAddressState {}

class LocationPermissionDenied extends CreateAddressState {}

class LocationPermissionDeniedForever extends CreateAddressState {}

class LocationPermissionAllowed extends CreateAddressState {}

class GetCurrentLocationSuccess extends CreateAddressState {
  final AddressTemp addressTemp;

  GetCurrentLocationSuccess({
    required this.addressTemp,
  });
}

class AddressTemp {
  String? address;
  String? phoneNumber;
  double? lat;
  double? lng;

  AddressTemp({this.address, this.phoneNumber, this.lat, this.lng});
}

class GetLocationError extends CreateAddressState {}
