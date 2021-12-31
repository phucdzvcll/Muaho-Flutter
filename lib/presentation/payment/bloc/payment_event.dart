part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent extends Equatable {}

class CreateOrderEvent extends PaymentEvent {
  final PaymentEntity paymentEntity;

  CreateOrderEvent({required this.paymentEntity});

  @override
  List<Object?> get props => [paymentEntity];
}

class UpdateAddressEvent extends PaymentEvent {
  final AddressInfoEntity addressInfoEntity;

  UpdateAddressEvent({
    required this.addressInfoEntity,
  });

  @override
  List<Object?> get props => [addressInfoEntity];
}
