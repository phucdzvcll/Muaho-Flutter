part of 'payment_bloc.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class LoadingState extends PaymentState {}

class GetPaymentInfoSuccess extends PaymentState {
  final PaymentInfoModel paymentInfoModel;

  GetPaymentInfoSuccess({required this.paymentInfoModel});
}

class CreateOrderSuccess extends PaymentState {
  final int orderId;

  CreateOrderSuccess({required this.orderId});
}

class CreatingOrder extends PaymentState {}

class CreateOrderFailed extends PaymentState {}
