import 'package:muaho/domain/domain.dart';

abstract class ShopRepository {
  Future<Either<Failure, ShopProductEntity>> getShopProducts(int shopId);
}
