import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_status.g.dart';

@JsonSerializable()
class OrderStatus extends Equatable {
  final String status;

  OrderStatus({required this.status});

  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);

  @override
  List<Object?> get props => [status];
}
