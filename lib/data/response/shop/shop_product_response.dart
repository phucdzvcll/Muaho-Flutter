import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop_product_response.g.dart';

@JsonSerializable()
class ShopProductResponse extends Equatable {
  final int shopId;
  final String shopName;
  final String? shopAddress;
  final List<ProductGroupResponse?>? groups;
  final List<ShopVoucherResponse>? vouchers;

  factory ShopProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopProductResponseToJson(this);

  const ShopProductResponse({
    required this.shopId,
    required this.shopName,
    this.shopAddress,
    this.groups,
    this.vouchers,
  });

  @override
  List<Object?> get props => [
        shopId,
        shopName,
        shopAddress,
        groups,
        vouchers,
      ];
}

@JsonSerializable()
class ProductGroupResponse extends Equatable {
  final int groupId;
  final String groupName;
  final List<ProductResponse?>? products;

  factory ProductGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductGroupResponseToJson(this);

  const ProductGroupResponse({
    required this.groupId,
    required this.groupName,
    this.products,
  });

  @override
  List<Object?> get props => [
        groupId,
        groupName,
        products,
      ];
}

@JsonSerializable()
class ProductResponse extends Equatable {
  final int productId;
  final String productName;
  @JsonKey(name: "produtPrice")
  final double? productPrice;
  final String? unit;
  final String? thumbUrl;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);

  const ProductResponse({
    required this.productId,
    required this.productName,
    this.productPrice,
    this.unit,
    this.thumbUrl,
  });

  @override
  List<Object?> get props => [
        productId,
        productName,
        productPrice,
        unit,
        thumbUrl,
      ];
}

@JsonSerializable()
class ShopVoucherResponse extends Equatable {
  final int id;
  final String code;
  final String? description;

  factory ShopVoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopVoucherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopVoucherResponseToJson(this);

  ShopVoucherResponse({
    required this.id,
    required this.code,
    this.description = "",
  });

  @override
  List<Object?> get props => [
        id,
        code,
        description,
      ];
}
