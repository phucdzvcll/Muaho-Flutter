import 'package:json_annotation/json_annotation.dart';

part 'shop_product_response.g.dart';

@JsonSerializable()
class ShopProductResponse {
  final int shopId;
  final String shopName;
  final String? shopAddress;
  final List<ProductGroupResponse?>? groups;
  final List<ShopVoucherResponse>? vouchers;

  factory ShopProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopProductResponseToJson(this);

//<editor-fold desc="Data Methods">

  const ShopProductResponse({
    required this.shopId,
    required this.shopName,
    this.shopAddress,
    this.groups,
    this.vouchers,
  });

  @override
  String toString() {
    return 'ShopProductResponse{' +
        ' shopId: $shopId,' +
        ' shopName: $shopName,' +
        ' shopAddress: $shopAddress,' +
        ' groups: $groups,' +
        ' vouchers: $vouchers,' +
        '}';
  }

//</editor-fold>
}

@JsonSerializable()
class ProductGroupResponse {
  final int groupId;
  final String groupName;
  final List<ProductResponse?>? products;

  factory ProductGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductGroupResponseToJson(this);

//<editor-fold desc="Data Methods">

  const ProductGroupResponse({
    required this.groupId,
    required this.groupName,
    this.products,
  });

  @override
  String toString() {
    return 'ShopGroupProduct{' +
        ' groupId: $groupId,' +
        ' groupName: $groupName,' +
        ' products: $products,' +
        '}';
  }
//</editor-fold>
}

@JsonSerializable()
class ProductResponse {
  final int productId;
  final String productName;
  @JsonKey(name: "produtPrice")
  final double? productPrice;
  final String? unit;
  final String? thumbUrl;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);

//<editor-fold desc="Data Methods">

  const ProductResponse({
    required this.productId,
    required this.productName,
    this.productPrice,
    this.unit,
    this.thumbUrl,
  });

  @override
  String toString() {
    return 'Product{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' produtPrice: $productPrice,' +
        ' unit: $unit,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }
//</editor-fold>
}

@JsonSerializable()
class ShopVoucherResponse {
  final int id;
  final String code;
  final String? description;

  factory ShopVoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopVoucherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopVoucherResponseToJson(this);

//<editor-fold desc="Data Methods">

  ShopVoucherResponse({
    required this.id,
    required this.code,
    this.description = "",
  });

//</editor-fold>
}
