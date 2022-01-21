part of 'order_history_delivering_bloc.dart';

@immutable
abstract class OrderHistoryDeliveringState extends Equatable {}

class OrderHistoryDeliveringInitial extends OrderHistoryDeliveringState {
  @override
  List<Object?> get props => [];
}

class OrderHistoryDeliveringLoading extends OrderHistoryDeliveringState {
  @override
  List<Object?> get props => [];
}

class OrderHistoryDeliveringSuccess extends OrderHistoryDeliveringState {
  final List<OrderHistoryDeliveringModel> orderHistoryDeliveries;

  OrderHistoryDeliveringSuccess({required this.orderHistoryDeliveries});

  @override
  List<Object?> get props => [];
}

class OrderHistoryDeliveringError extends OrderHistoryDeliveringState {
  @override
  List<Object?> get props => [];
}
