import '../../domain.dart';

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
