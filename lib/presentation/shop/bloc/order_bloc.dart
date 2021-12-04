import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/shop/get_shop_product_use_case.dart';
import 'package:muaho/presentation/shop/model/cart_model.dart';
import 'package:muaho/presentation/shop/model/product_model.dart';
import 'package:muaho/presentation/shop/model/shop_detail_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  GetShopProductUseCase _useCase = GetIt.instance.get();

  OrderBloc() : super(OrderInitial());

  List<Product> _products = [];
  List<Product> _currentProducts = [];

  List<ProductGroupEntity> _groups = [];

  String _shopName = "";
  String _address = "";

  int currentGroupId = -1;

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is GetShopDetailEvent) {
      yield* _handleRequestEvent(event);
    } else if (event is FilterProductEvent) {
      yield* _handleFilterEvent(event);
    } else if (event is AddToCartEvent) {
      yield* _handleAddToCartEvent(event);
    }
  }

  Stream<OrderState> _handleAddToCartEvent(AddToCartEvent event) async* {
    replaceProduct(event.product);
    filterProducts(currentGroupId);
    yield OrderSuccess(
        shopDetailModel: ShopDetailModel(
            cartOverView: createCartOverView(),
            currentGroupId: currentGroupId,
            shopName: _shopName,
            shopAddress: _address,
            groups: _groups,
            currentListProducts: _currentProducts));
  }

  Stream<OrderState> _handleRequestEvent(GetShopDetailEvent event) async* {
    Either<Failure, ShopProductEntity> result =
        await _useCase.execute(ShopProductParam(shopID: event.shopID));
    yield OrderLoading();
    if (result.isSuccess) {
      _products.addAll(result.success.products.map((e) => mapProduct(e)));
      _shopName = result.success.shopName;
      _address = result.success.shopAddress;
      _groups.addAll(result.success.groups);

      yield OrderSuccess(
          shopDetailModel: ShopDetailModel(
              cartOverView: createCartOverView(),
              currentGroupId: -1,
              shopName: _shopName,
              shopAddress: _address,
              groups: _groups,
              currentListProducts: _products));
    } else {
      yield OrderError();
    }
  }

  Product mapProduct(ProductEntity productEntity) {
    return Product(
      productId: productEntity.productId,
      productName: productEntity.productName,
      productPrice: productEntity.productPrice,
      groupId: productEntity.groupId,
      thumbUrl: productEntity.thumbUrl,
      price: productEntity.productPrice.formatDouble() +
          "đ / ${productEntity.unit.toLowerCase()}",
      amount: 0,
    );
  }

  Stream<OrderState> _handleFilterEvent(FilterProductEvent event) async* {
    filterProducts(event.groupID);
    currentGroupId = event.groupID;
    yield OrderSuccess(
        shopDetailModel: ShopDetailModel(
            currentGroupId: currentGroupId,
            shopName: _shopName,
            shopAddress: _address,
            groups: _groups,
            currentListProducts: _currentProducts,
            cartOverView: createCartOverView()));
  }

  CartOverViewModel createCartOverView() {
    int amount = 0;
    int totalItem = 0;
    double totalPrice = 0.0;

    if (_products.isNotEmpty) {
      _products.forEach((element) {
        if (element.amount > 0) {
          amount += element.amount;
          totalItem += 1;
          totalPrice += element.amount * element.productPrice;
        }
      });
    }

    return CartOverViewModel(
        amount: "$amount đơn vị - $totalItem sản phầm",
        totalPrice: totalPrice.formatDouble() + " VNĐ");
  }

  void replaceProduct(Product newProduct) {
    if (_products.isNotEmpty) {
      for (var product in _products) {
        if (product.productId == newProduct.productId) {
          _products[_products.indexOf(product)] = newProduct;
          break;
        }
      }
    }
  }

  void filterProducts(int groupID) {
    _currentProducts = [];
    if (groupID == -1) {
      _currentProducts.addAll(_products);
    } else {
      _currentProducts
          .addAll(_products.where((element) => element.groupId == groupID));
    }
  }
}
