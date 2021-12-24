import 'package:json_annotation/json_annotation.dart';

part 'order_status.g.dart';

@JsonSerializable()
class OrderStatus {
  final String status;

  OrderStatus({required this.status});

  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}
