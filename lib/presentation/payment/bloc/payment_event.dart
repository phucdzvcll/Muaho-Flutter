part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class RequestLocationPermission extends PaymentEvent {}

class RequestLocation extends PaymentEvent {}

class EditAddress extends PaymentEvent {
  final String newAddress;

  EditAddress({required this.newAddress});
}

class CreateOrderEvent extends PaymentEvent {}

class ClearCartStore extends PaymentEvent {}
