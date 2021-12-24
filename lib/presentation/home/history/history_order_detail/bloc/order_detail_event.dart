part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailEvent {}

class GetOrderDetailEvent extends OrderDetailEvent {
  final int orderID;

  GetOrderDetailEvent({required this.orderID});
}
