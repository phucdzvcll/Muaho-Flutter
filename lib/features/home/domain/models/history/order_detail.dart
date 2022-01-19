import 'package:equatable/equatable.dart';

class OrderDetailEntity extends Equatable {
  final int orderId;
  final String voucherCode;
  final double totalBeforeDiscount;
  final double voucherDiscount;
  final double total;
  final String deliveryAddress;
  final String deliveryPhoneNumber;
  final int shopId;
  final String shopName;
  final String shopAddress;
  final String status;
  final List<Product> products;

  const OrderDetailEntity({
    required this.orderId,
    required this.voucherCode,
    required this.totalBeforeDiscount,
    required this.voucherDiscount,
    required this.total,
    required this.deliveryAddress,
    required this.deliveryPhoneNumber,
    required this.shopId,
    required this.shopName,
    required this.shopAddress,
    required this.status,
    required this.products,
  });

  @override
  List<Object?> get props => [
        orderId,
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
        products,
      ];
}

class Product extends Equatable {
  final int productId;
  final double price;
  final int quantity;
  final double total;
  final String productName;
  final String thumbUrl;

  const Product({
    required this.productId,
    required this.price,
    required this.quantity,
    required this.total,
    required this.productName,
    required this.thumbUrl,
  });

  @override
  List<Object?> get props => [
        productId,
        price,
        quantity,
        total,
        productName,
        thumbUrl,
      ];
}
