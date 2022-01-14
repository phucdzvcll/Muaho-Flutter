import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class OrderHistoryDetailResponse extends Equatable {
  final int? orderId;
  final List<OrderProductDetailResponse>? products;
  final String? voucherCode;
  final double? totalBeforeDiscount;
  final double? voucherDiscount;
  final double? total;
  final String? deliveryAddress;
  final String? deliveryPhoneNumber;
  final int? shopId;
  final String? shopName;
  final String? shopAddress;
  final String? status;

  OrderHistoryDetailResponse({
    this.orderId,
    this.products,
    this.voucherCode,
    this.totalBeforeDiscount,
    this.voucherDiscount,
    this.total,
    this.deliveryAddress,
    this.deliveryPhoneNumber,
    this.shopId,
    this.shopName,
    this.shopAddress,
    this.status,
  });

  factory OrderHistoryDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDetailResponse(
      orderId: json.parseInt('orderId'),
      products:
          json.parseListObject('products', OrderProductDetailResponse.fromJson),
      voucherCode: json.parseString('voucherCode'),
      totalBeforeDiscount: json.parseDouble('totalBeforeDiscount'),
      voucherDiscount: json.parseDouble('voucherDiscount'),
      total: json.parseDouble('total'),
      deliveryAddress: json.parseString('deliveryAddress'),
      deliveryPhoneNumber: json.parseString('deliveryPhone_number'),
      shopId: json.parseInt('shopId'),
      shopName: json.parseString('shopName'),
      shopAddress: json.parseString('shopAddress'),
      status: json.parseString('status'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['orderId'] = orderId;
    data['voucherCode'] = voucherCode;
    data['totalBeforeDiscount'] = totalBeforeDiscount;
    data['voucherDiscount'] = voucherDiscount;
    data['total'] = total;
    data['deliveryAddress'] = deliveryAddress;
    data['deliveryPhone_number'] = deliveryPhoneNumber;
    data['shopId'] = shopId;
    data['shopName'] = shopName;
    data['shopAddress'] = shopAddress;
    data['status'] = status;
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        orderId,
        products,
        voucherCode,
        totalBeforeDiscount,
        voucherDiscount,
        total,
        deliveryAddress,
        deliveryPhoneNumber,
        shopId,
        shopName,
        shopAddress,
        status,
      ];
}

class OrderProductDetailResponse extends Equatable {
  final int? productId;
  final double? price;
  final int? quantity;
  final double? total;
  final String? productName;
  final String? productThumbUrl;

  OrderProductDetailResponse({
    this.productId,
    this.price,
    this.quantity,
    this.total,
    this.productName,
    this.productThumbUrl,
  });

  factory OrderProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderProductDetailResponse(
      productId: json.parseInt('productId'),
      price: json.parseDouble('price'),
      quantity: json.parseInt('quantity'),
      total: json.parseDouble('total'),
      productName: json.parseString('productName'),
      productThumbUrl: json.parseString('productThumbUrl'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productId'] = productId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['total'] = total;
    data['productName'] = productName;
    data['productThumbUrl'] = productThumbUrl;
    return data;
  }

  @override
  List<Object?> get props => [
        productId,
        price,
        quantity,
        total,
        productName,
        productThumbUrl,
      ];
}
