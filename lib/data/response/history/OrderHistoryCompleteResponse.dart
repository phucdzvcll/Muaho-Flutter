import 'package:json_annotation/json_annotation.dart';

part 'OrderHistoryCompleteResponse.g.dart';

@JsonSerializable()
class OrderHistoryCompleteResponse {
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

//<editor-fold desc="Data Methods">

  const OrderHistoryCompleteResponse({
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
    return 'OrderHistoryCompleteResponse{' +
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
