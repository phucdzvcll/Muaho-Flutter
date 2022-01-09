enum VoucherType {
  discount,
  percent,
}

class VoucherListItem {
  final int id;
  final String code;
  final String description;
  final double value;
  final VoucherType type;
  final int minOrderTotal;
  final bool isApplyForAllShop;
  final List<int> shops;
  final int numSecondRemain;

  const VoucherListItem({
    required this.id,
    required this.code,
    required this.description,
    required this.value,
    required this.type,
    required this.minOrderTotal,
    required this.isApplyForAllShop,
    required this.shops,
    required this.numSecondRemain,
  });
}