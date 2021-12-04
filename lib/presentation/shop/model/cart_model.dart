class CartOverViewModel {
  final String amount;
  final String totalPrice;

//<editor-fold desc="Data Methods">

  const CartOverViewModel({
    required this.amount,
    required this.totalPrice,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartOverViewModel &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          totalPrice == other.totalPrice);

  @override
  int get hashCode => amount.hashCode ^ totalPrice.hashCode;

  @override
  String toString() {
    return 'CartOverViewModel{' +
        ' amount: $amount,' +
        ' totalPrice: $totalPrice,' +
        '}';
  }

  CartOverViewModel copyWith({
    String? amout,
    String? totalItem,
    String? totalPrice,
  }) {
    return CartOverViewModel(
      amount: amout ?? this.amount,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
//</editor-fold>
}
