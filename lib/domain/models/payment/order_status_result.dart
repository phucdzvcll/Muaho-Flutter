import 'package:equatable/equatable.dart';

class OrderStatusResult extends Equatable {
  final String status;
  final int orderID;

  const OrderStatusResult({required this.status, required this.orderID});

  @override
  List<Object?> get props => [status, orderID];
}
