part of 'address_bloc.dart';

@immutable
abstract class AddressEvent {}

class RequestListAddressEvent extends AddressEvent {}

class ChangeCurrentAddress extends AddressEvent {
  final AddressInfoEntity addressInfoEntity;

  ChangeCurrentAddress({
    required this.addressInfoEntity,
  });
}

class RefreshListAddressEvent extends AddressEvent {}
