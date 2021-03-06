import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/order/data/response/shop_product_response.dart';
import 'package:muaho/features/order/data/services/shop_service.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';
import 'package:muaho/features/order/domain/repo/shop_repository.dart';

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
        Group? groupResponse = e;
        groupResponse.products?.forEach((element) {
          mapProductEntity(
              element, products, groupResponse.groupId.defaultZero());
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
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }

  ProductGroupEntity mapProductGroupEntity(Group? productGroup) {
    return ProductGroupEntity(
        groupId: (productGroup?.groupId).defaultZero(),
        groupName: (productGroup?.groupName).defaultEmpty());
  }

  ProductEntity mapProductEntity(
      ShopProduct? product, List<ProductEntity> products, int groupId) {
    var productEntity = ProductEntity(
        quantity: 0,
        groupId: groupId,
        productId: (product?.productId).defaultZero(),
        productName: (product?.productName).defaultEmpty(),
        productPrice: (product?.produtPrice).defaultZero(),
        unit: (product?.unit).defaultEmpty(),
        thumbUrl: (product?.thumbUrl).defaultEmpty());
    products.add(productEntity);
    return productEntity;
  }

  VoucherEntity mapVoucher(Voucher? element) {
    VoucherEntity voucherEntity = VoucherEntity(
        id: (element?.id).defaultZero(),
        code: (element?.code).defaultEmpty(),
        description: (element?.description).defaultEmpty());
    return voucherEntity;
  }
}
