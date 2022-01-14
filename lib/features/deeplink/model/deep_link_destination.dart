import 'package:equatable/equatable.dart';

abstract class DeepLinkDestination extends Equatable {
  const DeepLinkDestination();
}

class ShopDetailDeepLinkDestination extends DeepLinkDestination {
  final int shopId;

  @override
  List<Object?> get props => [shopId];

  const ShopDetailDeepLinkDestination({
    required this.shopId,
  });
}

class OrderDetailDeepLinkDestination extends DeepLinkDestination {
  final int orderId;

  @override
  List<Object?> get props => [orderId];

  const OrderDetailDeepLinkDestination({
    required this.orderId,
  });
}

class ShopCategoryDeepLinkDestination extends DeepLinkDestination {
  final int shopCategory;

  @override
  List<Object?> get props => [shopCategory];

  const ShopCategoryDeepLinkDestination({
    required this.shopCategory,
  });
}

class SearchDeepLinkDestination extends DeepLinkDestination {
  final String keyword;

  @override
  List<Object?> get props => [keyword];

  const SearchDeepLinkDestination({
    required this.keyword,
  });
}
