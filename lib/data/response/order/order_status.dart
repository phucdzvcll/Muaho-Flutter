import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class OrderStatus extends Equatable {
  final String? status;
  final int? orderId;

  OrderStatus({
    this.status,
    this.orderId,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      status: json.parseString('status'),
      orderId: json.parseInt('orderId'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['orderId'] = orderId;
    return data;
  }

  @override
  List<Object?> get props => [
        status,
        orderId,
      ];
}
