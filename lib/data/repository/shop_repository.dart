import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/data/remote/shop/shop_service.dart';
import 'package:muaho/domain/domain.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopService service = GetIt.instance.get();

  @override
  Future<Either<Failure, ShopProductEntity>> getShopProducts(int shopId) async {
    var request = service.getShopProduct(shopId);
    var result = await handleNetworkResult(request);
    if (result.isSuccess()) {
      List<ProductGroupEntity> groups = [];
      List<VoucherEntity> vouchers = [];
      result.response?.vouchers?.defaultEmpty().forEach((element) {
        vouchers.add(mapVoucher(element));
      });
      result.response?.groups?.defaultEmpty().forEach((element) {
        groups.add(mapProductGroupEntity(element));
      });
      return SuccessValue(ShopProductEntity(
          groups: groups,
          shopAddress: (result.response?.shopAddress).defaultEmpty(),
          shopId: (result.response?.shopId).defaultZero(),
          shopName: (result.response?.shopName).defaultEmpty(),
          vouchers: vouchers));
    } else {
      return FailValue(Failure());
    }
  }

  ProductGroupEntity mapProductGroupEntity(ProductGroupResponse? productGroup) {
    return ProductGroupEntity(
        groupId: (productGroup?.groupId).defaultZero(),
        groupName: (productGroup?.groupName).defaultEmpty(),
        products: (productGroup?.products)
            .defaultEmpty()
            .map((e) => mapProductEntity(e))
            .toList());
  }

  ProductEntity mapProductEntity(ProductResponse? product) {
    return ProductEntity(
        productId: (product?.productId).defaultZero(),
        productName: (product?.productName).defaultEmpty(),
        produtPrice: (product?.productPrice).defaultZero(),
        unit: (product?.unit).defaultEmpty(),
        thumbUrl: (product?.thumbUrl).defaultEmpty());
  }

  VoucherEntity mapVoucher(ShopVoucherResponse? element) {
    VoucherEntity voucherEntity = VoucherEntity(
        id: (element?.id).defaultZero(),
        code: (element?.code).defaultEmpty(),
        description: (element?.description).defaultEmpty());
    return voucherEntity;
  }
}
