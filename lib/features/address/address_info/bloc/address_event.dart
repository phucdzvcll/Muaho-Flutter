part of 'address_bloc.dart';

@immutable
abstract class AddressEvent extends Equatable {}

class RequestListAddressEvent extends AddressEvent {
  @override
  List<Object?> get props => [];
}

class ChangeCurrentAddress extends AddressEvent {
  final AddressInfoEntity addressInfoEntity;

  ChangeCurrentAddress({
    required this.addressInfoEntity,
  });

  @override
  List<Object?> get props => [addressInfoEntity];
}

class RefreshListAddressEvent extends AddressEvent {
  @override
  List<Object?> get props => [];
}
