import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OrderHistoryDeliveryResponse.g.dart';

@JsonSerializable()
class OrderHistoryDeliveringResponse extends Equatable {
  final int? orderId;
  final String? orderCode;
  final String? shopName;
  final int? itemCount;
  final double? total;
  final String? status;
  final String? thumbUrl;

  factory OrderHistoryDeliveringResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryDeliveringResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryDeliveringResponseToJson(this);

  const OrderHistoryDeliveringResponse({
    this.orderId,
    this.orderCode,
    this.shopName,
    this.itemCount,
    this.total,
    this.status,
    this.thumbUrl,
  });

  @override
  List<Object?> get props => [
        orderId,
        orderCode,
        shopName,
        itemCount,
        total,
        status,
        thumbUrl,
      ];
}
