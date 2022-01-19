import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';
import 'package:muaho/features/order/domain/repo/shop_repository.dart';

class GetShopProductUseCase
    extends BaseUseCase<ShopProductParam, ShopProductEntity> {
  final ShopRepository shopRepository;

  GetShopProductUseCase({required this.shopRepository});

  @override
  Future<Either<Failure, ShopProductEntity>> executeInternal(
      ShopProductParam input) async {
    return await shopRepository.getShopProducts(input.shopID);
  }
}

class ShopProductParam {
  final int shopID;

  ShopProductParam({required this.shopID});
}
