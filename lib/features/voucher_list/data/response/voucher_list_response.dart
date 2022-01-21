import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class VoucherListResponse extends Equatable {
  final int? id;
  final String? code;
  final String? description;
  final double? value;
  final String? type;
  final int? min_order_total;
  final bool? is_apply_for_all_shop;
  final List<int>? shops;
  final DateTime? lastDate;

  VoucherListResponse({
    this.id,
    this.code,
    this.description,
    this.value,
    this.type,
    this.min_order_total,
    this.is_apply_for_all_shop,
    this.shops,
    this.lastDate,
  });

  factory VoucherListResponse.fromJson(Map<String, dynamic> json) {
    return VoucherListResponse(
      id: json.parseInt('id'),
      code: json.parseString('code'),
      description: json.parseString('description'),
      value: json.parseDouble('value'),
      type: json.parseString('type'),
      min_order_total: json.parseInt('min_order_total'),
      is_apply_for_all_shop: json.parseBool('is_apply_for_all_shop'),
      shops: json.parseListInt('shops', defaultValue: 0),
      lastDate: json.parseDatetime('lastDate'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['value'] = value;
    data['type'] = type;
    data['min_order_total'] = min_order_total;
    data['is_apply_for_all_shop'] = is_apply_for_all_shop;
    data['lastDate'] = lastDate;
    if (shops != null) {
      data['shops'] = shops;
    }
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        code,
        description,
        value,
        type,
        min_order_total,
        is_apply_for_all_shop,
        shops,
        lastDate,
      ];
}
