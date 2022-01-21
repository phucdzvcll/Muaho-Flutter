part of 'payment_bloc.dart';

@immutable
abstract class PaymentState extends Equatable {}

class PaymentInitial extends PaymentState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends PaymentState {
  @override
  List<Object?> get props => [];
}

class GetPaymentInfoSuccess extends PaymentState {
  final PaymentInfoModel paymentInfoModel;

  GetPaymentInfoSuccess({required this.paymentInfoModel});

  @override
  List<Object?> get props => [paymentInfoModel];
}

class CreateOrderSuccess extends PaymentState {
  final int orderId;

  CreateOrderSuccess({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class CreatingOrder extends PaymentState {
  @override
  List<Object?> get props => [];
}

class CreateOrderFailed extends PaymentState {
  @override
  List<Object?> get props => [];
}

class SignInState extends PaymentState {
  final bool isSignIn;

  SignInState({
    required this.isSignIn,
  });

  @override
  List<Object?> get props => [isSignIn];
}
