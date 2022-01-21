import 'package:flutter/cupertino.dart';
import 'package:muaho/features/deeplink/model/deep_link_destination.dart';
import 'package:muaho/features/home/presentation/history/history_order_detail/order_detail_screen.dart';
import 'package:muaho/features/home/presentation/history/models/order_detail_argument.dart';
import 'package:muaho/features/order/presentation/order_screen.dart';
import 'package:muaho/features/search/search_shop/ui/search_shop.dart';

class DeepLinkNavigator {
  Future open({
    required BuildContext context,
    required DeepLinkDestination deepLinkDestination,
  }) async {
    if (deepLinkDestination is ShopDetailDeepLinkDestination) {
      return Navigator.pushNamed(
        context,
        OrderScreen.routeName,
        arguments: ShopArgument(shopId: deepLinkDestination.shopId),
      );
    } else if (deepLinkDestination is ShopCategoryDeepLinkDestination) {
      return Navigator.pushNamed(
        context,
        SearchShopScreen.routeName,
        arguments: SearchShopByCategory(
          categoryId: deepLinkDestination.shopCategory,
        ),
      );
    } else if (deepLinkDestination is OrderDetailDeepLinkDestination) {
      return Navigator.pushNamed(
        context,
        OrderDetail.routeName,
        arguments: OrderDetailArgument(orderID: deepLinkDestination.orderId),
      );
    } else if (deepLinkDestination is SearchDeepLinkDestination) {
      return Navigator.pushNamed(
        context,
        SearchShopScreen.routeName,
        arguments: SearchShopByKeyword(
          keyword: deepLinkDestination.keyword,
        ),
      );
    }
  }
}
