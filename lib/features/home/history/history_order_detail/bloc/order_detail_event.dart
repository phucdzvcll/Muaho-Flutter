part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailEvent extends Equatable {}

class GetOrderDetailEvent extends OrderDetailEvent {
  final int orderID;

  GetOrderDetailEvent({required this.orderID});

  @override
  List<Object?> get props => [orderID];
}
