part of 'address_bloc.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class GetListAddressSuccess extends AddressState {
  final List<AddressInfoEntity> addressInfoEntities;

  GetListAddressSuccess({
    required this.addressInfoEntities,
  });
}

class Error extends AddressState {}

class ChangeAddressSuccess extends AddressState {
  final AddressInfoEntity addressInfoEntity;

  ChangeAddressSuccess({
    required this.addressInfoEntity,
  });
}
