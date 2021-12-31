part of 'create_address_bloc.dart';

@immutable
abstract class CreateAddressState extends Equatable {}

class CreateAddressInitial extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class LocationDisable extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class LocationPermissionDenied extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class LocationPermissionDeniedForever extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class LocationPermissionAllowed extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class AddressUpdateState extends CreateAddressState {
  final String address;

  AddressUpdateState({
    required this.address,
  });

  @override
  List<Object?> get props => [address];
}

class LocationUpdateState extends CreateAddressState {
  final double lat;
  final double lng;

  @override
  List<Object?> get props => [lat, lng];

  LocationUpdateState({
    required this.lat,
    required this.lng,
  });
}

class RequestingAddressState extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class RequestAddressManualState extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class FailRequestAddressState extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class TextingPhoneNumberState extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class PhoneNumberValidated extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class PhoneNumberNotValidated extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class AddressEmpty extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class PhoneEmpty extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class CreatingAddress extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class CreateAddressSuccess extends CreateAddressState {
  @override
  List<Object?> get props => [];
}

class CreateAddressFail extends CreateAddressState {
  @override
  List<Object?> get props => [];
}
