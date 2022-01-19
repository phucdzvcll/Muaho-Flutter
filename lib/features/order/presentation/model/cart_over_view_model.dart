import 'package:muaho/features/payment/data/response/order_body.dart';

class CartOverViewModel {
  final String amount;
  final String totalPrice;
  final List<OrderProduct> products;

//<editor-fold desc="Data Methods">

  const CartOverViewModel({
    required this.amount,
    required this.totalPrice,
    required this.products,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartOverViewModel &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          totalPrice == other.totalPrice &&
          products == other.products);

  @override
  int get hashCode => amount.hashCode ^ totalPrice.hashCode ^ products.hashCode;

  @override
  String toString() {
    return 'CartOverViewModel{' +
        ' amount: $amount,' +
        ' totalPrice: $totalPrice,' +
        ' products: $products,' +
        '}';
  }

  CartOverViewModel copyWith({
    String? amount,
    String? totalPrice,
    List<OrderProduct>? products,
  }) {
    return CartOverViewModel(
      amount: amount ?? this.amount,
      totalPrice: totalPrice ?? this.totalPrice,
      products: products ?? this.products,
    );
  }

//</editor-fold>
}
