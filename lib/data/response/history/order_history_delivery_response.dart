import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class OrderHistoryDeliveringResponse extends Equatable {
  final int? orderId;
  final String? orderCode;
  final String? shopName;
  final int? itemCount;
  final double? total;
  final String? status;
  final String? thumbUrl;

  OrderHistoryDeliveringResponse({
    this.orderId,
    this.orderCode,
    this.shopName,
    this.itemCount,
    this.total,
    this.status,
    this.thumbUrl,
  });

  factory OrderHistoryDeliveringResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDeliveringResponse(
      orderId: json.parseInt('orderId'),
      orderCode: json.parseString('orderCode'),
      shopName: json.parseString('shopName'),
      itemCount: json.parseInt('itemCount'),
      total: json.parseDouble('total'),
      status: json.parseString('status'),
      thumbUrl: json.parseString('thumbUrl'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['orderId'] = orderId;
    data['orderCode'] = orderCode;
    data['shopName'] = shopName;
    data['itemCount'] = itemCount;
    data['total'] = total;
    data['status'] = status;
    data['thumbUrl'] = thumbUrl;
    return data;
  }

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
