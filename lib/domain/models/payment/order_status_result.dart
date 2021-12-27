import 'package:equatable/equatable.dart';

class OrderStatusResult extends Equatable {
  final String status;

  const OrderStatusResult({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
