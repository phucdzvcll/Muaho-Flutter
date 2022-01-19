part of 'create_address_bloc.dart';

@immutable
abstract class CreateAddressEvent extends Equatable {}

class PickLocationEvent extends CreateAddressEvent {
  final double lat;
  final double lng;

  @override
  List<Object?> get props => [lat, lng];

  PickLocationEvent({
    required this.lat,
    required this.lng,
  });
}

class TextingAddress extends CreateAddressEvent {
  final String value;

  TextingAddress({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}

class TextingPhone extends CreateAddressEvent {
  final String value;

  TextingPhone({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}

class RequestLocation extends CreateAddressEvent {
  @override
  List<Object?> get props => [];
}

class ClearAddress extends CreateAddressEvent {
  @override
  List<Object?> get props => [];
}

class SubmitCreateAddress extends CreateAddressEvent {
  @override
  List<Object?> get props => [];
}
