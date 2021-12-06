part of 'order_history_delivering_bloc.dart';

@immutable
abstract class OrderHistoryDeliveringState {}

class OrderHistoryDeliveringInitial extends OrderHistoryDeliveringState {}

class OrderHistoryDeliveringLoading extends OrderHistoryDeliveringState {}

class OrderHistoryDeliveringSuccess extends OrderHistoryDeliveringState {
  final List<OrderHistoryDeliveringModel> orderHistoryDeliveries;

  OrderHistoryDeliveringSuccess({required this.orderHistoryDeliveries});
}

class OrderHistoryDeliveringError extends OrderHistoryDeliveringState {}
