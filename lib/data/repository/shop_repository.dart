import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/data/remote/shop/shop_service.dart';
import 'package:muaho/domain/domain.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopService service;

  ShopRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, ShopProductEntity>> getShopProducts(int shopId) async {
    var request = service.getShopProduct(shopId);
    var result = await handleNetworkResult(request);
    if (result.isSuccess()) {
      List<ProductGroupEntity> groups = [];
      List<VoucherEntity> vouchers = [];
      List<ProductEntity> products = [];
      groups.add(ProductGroupEntity(groupId: -1, groupName: "Tất Cả"));

      result.response?.vouchers?.defaultEmpty().forEach((element) {
        vouchers.add(mapVoucher(element));
      });
      result.response?.groups?.defaultEmpty().forEach((element) {
        groups.add(mapProductGroupEntity(element));
      });

      (result.response?.groups).defaultEmpty().forEach((e) {
        ProductGroupResponse groupResponse = e;
        groupResponse.products.defaultEmpty().forEach((element) {
          mapProductEntity(element, products, groupResponse.groupId);
        });
      });
      return SuccessValue(ShopProductEntity(
          groups: groups,
          shopAddress: (result.response?.shopAddress).defaultEmpty(),
          shopId: (result.response?.shopId).defaultZero(),
          shopName: (result.response?.shopName).defaultEmpty(),
          vouchers: vouchers,
          products: products));
    } else {
      return FailValue(Failure());
    }
  }

  ProductGroupEntity mapProductGroupEntity(ProductGroupResponse? productGroup) {
    return ProductGroupEntity(
        groupId: (productGroup?.groupId).defaultZero(),
        groupName: (productGroup?.groupName).defaultEmpty());
  }

  ProductEntity mapProductEntity(
      ProductResponse? product, List<ProductEntity> products, int groupId) {
    var productEntity = ProductEntity(
        groupId: groupId,
        productId: (product?.productId).defaultZero(),
        productName: (product?.productName).defaultEmpty(),
        productPrice: (product?.productPrice).defaultZero(),
        unit: (product?.unit).defaultEmpty(),
        thumbUrl: (product?.thumbUrl).defaultEmpty());
    products.add(productEntity);
    return productEntity;
  }

  VoucherEntity mapVoucher(ShopVoucherResponse? element) {
    VoucherEntity voucherEntity = VoucherEntity(
        id: (element?.id).defaultZero(),
        code: (element?.code).defaultEmpty(),
        description: (element?.description).defaultEmpty());
    return voucherEntity;
  }
}
