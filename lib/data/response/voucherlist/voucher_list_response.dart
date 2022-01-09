import 'package:json_annotation/json_annotation.dart';

part 'voucher_list_response.g.dart';

@JsonSerializable()
class VoucherListResponse {
  int? id;
  String? code;
  String? description;
  double? value;
  String? type;
  int? minOrderTotal;
  bool? isApplyForAllShop;
  List<int>? shops;
  DateTime? lastDate;

  factory VoucherListResponse.fromJson(Map<String, dynamic> json) =>
  _$VoucherListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherListResponseToJson(this);

  VoucherListResponse({
    this.id,
    this.code,
    this.description,
    this.value,
    this.type,
    this.minOrderTotal,
    this.isApplyForAllShop,
    this.shops,
    this.lastDate,
  });
}