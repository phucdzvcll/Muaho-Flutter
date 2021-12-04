import 'package:get_it/get_it.dart';

import '../../domain.dart';

class GetShopProductUseCase
    extends BaseUseCase<ShopProductParam, ShopProductEntity> {
  final ShopRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, ShopProductEntity>> executeInternal(
      ShopProductParam input) async {
    return await repository.getShopProducts(input.shopID);
  }
}

class ShopProductParam {
  final int shopID;

  ShopProductParam({required this.shopID});
}
