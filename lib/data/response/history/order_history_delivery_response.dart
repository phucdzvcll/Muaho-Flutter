import 'package:json_annotation/json_annotation.dart';

part 'order_history_delivery_response.g.dart';

@JsonSerializable()
class OrderHistoryDeliveringResponse {
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

//<editor-fold desc="Data Methods">

  const OrderHistoryDeliveringResponse({
    required this.orderId,
    required this.orderCode,
    required this.shopName,
    required this.itemCount,
    required this.total,
    required this.status,
    required this.thumbUrl,
  });

  @override
  String toString() {
    return 'OrderHistoryDeliveringResponse{' +
        ' orderId: $orderId,' +
        ' orderCode: $orderCode,' +
        ' shopName: $shopName,' +
        ' itemCount: $itemCount,' +
        ' total: $total,' +
        ' status: $status,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

//</editor-fold>
}
