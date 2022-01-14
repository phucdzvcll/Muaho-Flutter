import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class ShopProductResponse extends Equatable {
  final int? shopId;
  final String? shopName;
  final String? shopAddress;
  final List<Group>? groups;
  final List<Voucher>? vouchers;

  ShopProductResponse({
    this.shopId,
    this.shopName,
    this.shopAddress,
    this.groups,
    this.vouchers,
  });

  factory ShopProductResponse.fromJson(Map<String, dynamic> json) {
    return ShopProductResponse(
      shopId: json.parseInt('shopId'),
      shopName: json.parseString('shopName'),
      shopAddress: json.parseString('shopAddress'),
      groups: json.parseListObject('groups', Group.fromJson),
      vouchers: json.parseListObject('vouchers', Voucher.fromJson),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['shopId'] = shopId;
    data['shopName'] = shopName;
    data['shopAddress'] = shopAddress;
    if (groups != null) {
      data['groups'] = groups?.map((v) => v.toJson()).toList();
    }
    if (vouchers != null) {
      data['vouchers'] = vouchers?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        shopId,
        shopName,
        shopAddress,
        groups,
        vouchers,
      ];
}

class Group extends Equatable {
  final int? groupId;
  final String? groupName;
  final List<ShopProduct>? products;

  Group({
    this.groupId,
    this.groupName,
    this.products,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json.parseInt('groupId'),
      groupName: json.parseString('groupName'),
      products: json.parseListObject('products', ShopProduct.fromJson),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        groupId,
        groupName,
        products,
      ];
}

class ShopProduct extends Equatable {
  final int? productId;
  final String? productName;
  final double? produtPrice;
  final String? unit;
  final String? thumbUrl;

  ShopProduct({
    this.productId,
    this.productName,
    this.produtPrice,
    this.unit,
    this.thumbUrl,
  });

  factory ShopProduct.fromJson(Map<String, dynamic> json) {
    return ShopProduct(
      productId: json.parseInt('productId'),
      productName: json.parseString('productName'),
      produtPrice: json.parseDouble('produtPrice'),
      unit: json.parseString('unit'),
      thumbUrl: json.parseString('thumbUrl'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productId'] = productId;
    data['productName'] = productName;
    data['produtPrice'] = produtPrice;
    data['unit'] = unit;
    data['thumbUrl'] = thumbUrl;
    return data;
  }

  @override
  List<Object?> get props => [
        productId,
        productName,
        produtPrice,
        unit,
        thumbUrl,
      ];
}

class Voucher extends Equatable {
  final int? id;
  final String? code;
  final String? description;

  Voucher({
    this.id,
    this.code,
    this.description,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json.parseInt('id'),
      code: json.parseString('code'),
      description: json.parseString('description'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        code,
        description,
      ];
}
