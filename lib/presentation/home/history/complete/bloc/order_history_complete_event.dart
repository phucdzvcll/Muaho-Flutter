part of 'order_history_complete_bloc.dart';

@immutable
abstract class OrderHistoryCompleteEvent extends Equatable {}

class GetOrderHistoryCompleteEvent extends OrderHistoryCompleteEvent {
  @override
  List<Object?> get props => [];
}
