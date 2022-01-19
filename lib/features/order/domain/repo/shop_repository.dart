import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';

abstract class ShopRepository {
  Future<Either<Failure, ShopProductEntity>> getShopProducts(int shopId);
}
