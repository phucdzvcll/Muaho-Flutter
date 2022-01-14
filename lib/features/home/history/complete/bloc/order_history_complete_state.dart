part of 'order_history_complete_bloc.dart';

@immutable
abstract class OrderHistoryCompleteState extends Equatable {}

class OrderHistoryCompleteInitial extends OrderHistoryCompleteState {
  @override
  List<Object?> get props => [];
}

class OrderHistoryCompleteLoading extends OrderHistoryCompleteState {
  @override
  List<Object?> get props => [];
}

class OrderHistoryCompleteSuccess extends OrderHistoryCompleteState {
  final List<OrderHistoryCompleteModel> orderHistoryDeliveries;

  OrderHistoryCompleteSuccess({required this.orderHistoryDeliveries});

  @override
  List<Object?> get props => [orderHistoryDeliveries];
}

class OrderHistoryCompleteError extends OrderHistoryCompleteState {
  @override
  List<Object?> get props => [];
}
