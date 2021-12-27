part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class CreateOrderEvent extends PaymentEvent {
  final PaymentEntity paymentEntity;

  CreateOrderEvent({required this.paymentEntity});
}
