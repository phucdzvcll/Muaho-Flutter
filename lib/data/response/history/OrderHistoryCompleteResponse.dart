import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OrderHistoryCompleteResponse.g.dart';

@JsonSerializable()
class OrderHistoryCompleteResponse extends Equatable {
  final int? orderId;
  final String? orderCode;
  final String? shopName;
  final int? itemCount;
  final double? total;
  final String? status;
  final String? thumbUrl;

  factory OrderHistoryCompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryCompleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryCompleteResponseToJson(this);

  const OrderHistoryCompleteResponse({
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
