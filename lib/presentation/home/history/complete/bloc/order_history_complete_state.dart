part of 'order_history_complete_bloc.dart';

@immutable
abstract class OrderHistoryCompleteState {}

class OrderHistoryCompleteInitial extends OrderHistoryCompleteState {}

class OrderHistoryCompleteLoading extends OrderHistoryCompleteState {}

class OrderHistoryCompleteSuccess extends OrderHistoryCompleteState {
  final List<OrderHistoryCompleteModel> orderHistoryDeliveries;

  OrderHistoryCompleteSuccess({required this.orderHistoryDeliveries});
}

class OrderHistoryCompleteError extends OrderHistoryCompleteState {}
