import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class OrderBody extends Equatable {
  final int? voucherId;
  final double? totalBeforeDiscount;
  final double? voucherDiscount;
  final double? total;
  final int? userId;
  final int? deliveryAddressID;
  final int? shopId;
  final List<OrderProduct>? products;

  OrderBody({
    this.voucherId,
    this.totalBeforeDiscount,
    this.voucherDiscount,
    this.total,
    this.userId,
    this.deliveryAddressID,
    this.shopId,
    this.products,
  });

  factory OrderBody.fromJson(Map<String, dynamic> json) {
    return OrderBody(
      voucherId: json.parseInt('voucherId'),
      totalBeforeDiscount: json.parseDouble('totalBeforeDiscount'),
      voucherDiscount: json.parseDouble('voucherDiscount'),
      total: json.parseDouble('total'),
      userId: json.parseInt('userId'),
      deliveryAddressID: json.parseInt('deliveryAddressID'),
      shopId: json.parseInt('shopId'),
      products: json.parseListObject('products', OrderProduct.fromJson),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['voucherId'] = voucherId;
    data['totalBeforeDiscount'] = totalBeforeDiscount;
    data['voucherDiscount'] = voucherDiscount;
    data['total'] = total;
    data['userId'] = userId;
    data['deliveryAddressID'] = deliveryAddressID;
    data['shopId'] = shopId;
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        voucherId,
        totalBeforeDiscount,
        voucherDiscount,
        total,
        userId,
        deliveryAddressID,
        shopId,
        products,
      ];
}

class OrderProduct extends Equatable {
  final int? productId;
  final double? price;
  final int? quantity;
  final double? total;

  OrderProduct({
    this.productId,
    this.price,
    this.quantity,
    this.total,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productId: json.parseInt('productId'),
      price: json.parseDouble('price'),
      quantity: json.parseInt('quantity'),
      total: json.parseDouble('total'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productId'] = productId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['total'] = total;
    return data;
  }

  @override
  List<Object?> get props => [
        productId,
        price,
        quantity,
        total,
      ];
}
