class OrderStatusResult {
  final String status;

//<editor-fold desc="Data Methods">

  const OrderStatusResult({
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderStatusResult &&
          runtimeType == other.runtimeType &&
          status == other.status);

  @override
  int get hashCode => status.hashCode;

  @override
  String toString() {
    return 'OrderStatusResult{' + ' status: $status,' + '}';
  }

  OrderStatusResult copyWith({
    String? status,
  }) {
    return OrderStatusResult(
      status: status ?? this.status,
    );
  }

//</editor-fold>
}
