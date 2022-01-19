import 'package:equatable/equatable.dart';

class ShopProductEntity extends Equatable {
  final int shopId;
  final String shopName;
  final String shopAddress;
  final List<ProductGroupEntity> groups;
  final List<VoucherEntity> vouchers;
  final List<ProductEntity> products;

  const ShopProductEntity({
    required this.shopId,
    required this.shopName,
    required this.shopAddress,
    required this.groups,
    required this.vouchers,
    required this.products,
  });

  @override
  List<Object?> get props =>
      [shopId, shopName, shopAddress, groups, vouchers, products];
}

class ProductGroupEntity extends Equatable {
  final int groupId;
  final String groupName;

  const ProductGroupEntity({
    required this.groupId,
    required this.groupName,
  });

  @override
  List<Object?> get props => [groupId, groupName];
}

class ProductEntity extends Equatable {
  final int productId;
  final String productName;
  final double productPrice;
  final int groupId;
  final String unit;
  final String thumbUrl;
  final int quantity;

  const ProductEntity({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.groupId,
    required this.unit,
    required this.thumbUrl,
    required this.quantity,
  });

  ProductEntity copyWith({
    int? productId,
    String? productName,
    double? productPrice,
    int? groupId,
    String? unit,
    String? thumbUrl,
    int? quantity,
  }) {
    return ProductEntity(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      groupId: groupId ?? this.groupId,
      unit: unit ?? this.unit,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props =>
      [productId, productName, productPrice, groupId, unit, thumbUrl, quantity];
}

class VoucherEntity {
  final int id;
  final String code;
  final String description;

  const VoucherEntity({
    required this.id,
    required this.code,
    required this.description,
  });

  VoucherEntity copyWith({
    int? id,
    String? code,
    String? description,
  }) {
    return VoucherEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
    );
  }
}
