part of 'address_bloc.dart';

@immutable
abstract class AddressState extends Equatable {}

class AddressInitial extends AddressState {
  @override
  List<Object?> get props => [];
}

class GetListAddressSuccess extends AddressState {
  final List<AddressInfoEntity> addressInfoEntities;

  GetListAddressSuccess({
    required this.addressInfoEntities,
  });

  @override
  List<Object?> get props => [addressInfoEntities];
}

class Error extends AddressState {
  @override
  List<Object?> get props => [];
}

class ChangeAddressSuccess extends AddressState {
  final AddressInfoEntity addressInfoEntity;

  ChangeAddressSuccess({
    required this.addressInfoEntity,
  });

  @override
  List<Object?> get props => [addressInfoEntity];
}
