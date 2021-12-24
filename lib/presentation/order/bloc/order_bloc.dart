import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/common/model/cart_store.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/shop/get_shop_product_use_case.dart';
import 'package:muaho/presentation/components/model/cart_over_view_model.dart';
import 'package:muaho/presentation/order/model/order_detail_model.dart';

import '../../../main.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  GetShopProductUseCase _useCase = GetIt.instance.get();
  CartStore cartStore = getIt.get<CartStore>();

  OrderBloc() : super(OrderInitial());

  List<ProductStore> _totalProducts = [];
  List<ProductStore> _currentProducts = [];

  List<ProductGroupEntity> _groups = [];

  String _shopName = "";
  String _address = "";
  int _shopID = -1;
  int currentGroupId = -1;

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is GetShopDetailEvent) {
      yield* _handleRequestEvent(event);
    } else if (event is FilterProductEvent) {
      yield* _handleFilterEvent(event);
    } else if (event is AddToCartEvent) {
      yield* _handleAddToCartEvent(event);
    } else if (event is ChangeShopEvent) {
      yield* _handleChangeShopEvent(event);
    }
  }

  Stream<OrderState> _handleChangeShopEvent(ChangeShopEvent event) async* {
    cartStore.shopId = _shopID;
    cartStore.shopAddress = _address;
    cartStore.shopName = _shopName;
    cartStore.productStores.clear();
    cartStore.editCart(event.product);
    filterProductsByProductStore();
    yield OrderSuccess(
        shopDetailModel: OrderDetailModel(
            shopID: _shopID,
            cartOverView: getCartOverView(),
            currentGroupId: currentGroupId,
            shopName: _shopName,
            shopAddress: _address,
            groups: _groups,
            currentListProducts: _currentProducts));
  }

  Stream<OrderState> _handleAddToCartEvent(AddToCartEvent event) async* {
    if (cartStore.shopId == -1) {
      cartStore.shopId = _shopID;
      cartStore.shopAddress = _address;
      cartStore.shopName = _shopName;
    }
    cartStore.editCart(event.product);
    filterProductsByProductStore();
    yield OrderSuccess(
        shopDetailModel: OrderDetailModel(
            shopID: _shopID,
            cartOverView: getCartOverView(),
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
      _totalProducts.clear();
      _totalProducts.addAll(result.success.products.map((e) => mapProduct(e)));
      _shopName = result.success.shopName;
      _address = result.success.shopAddress;
      _groups.clear();
      _groups.addAll(result.success.groups);
      _shopID = event.shopID;
      filterProductsByGroup(-1);
      filterProductsByProductStore();
      yield OrderSuccess(
          shopDetailModel: OrderDetailModel(
              shopID: event.shopID,
              cartOverView: getCartOverView(),
              currentGroupId: -1,
              shopName: _shopName,
              shopAddress: _address,
              groups: _groups,
              currentListProducts: _currentProducts));
    } else {
      yield OrderError();
    }
  }

  ProductStore mapProduct(ProductEntity productEntity) {
    return ProductStore(
      productId: productEntity.productId,
      productName: productEntity.productName,
      productPrice: productEntity.productPrice,
      groupId: productEntity.groupId,
      thumbUrl: productEntity.thumbUrl,
      quantity: 0,
      unit: productEntity.unit,
    );
  }

  Stream<OrderState> _handleFilterEvent(FilterProductEvent event) async* {
    filterProductsByGroup(event.groupID);
    filterProductsByProductStore();
    currentGroupId = event.groupID;
    yield OrderSuccess(
        shopDetailModel: OrderDetailModel(
            shopID: _shopID,
            currentGroupId: currentGroupId,
            shopName: _shopName,
            shopAddress: _address,
            groups: _groups,
            currentListProducts: _currentProducts,
            cartOverView: getCartOverView()));
  }

  CartOverViewModel getCartOverView() {
    int amount = 0;
    int totalItem = 0;
    double totalPrice = 0.0;

    if (cartStore.productStores.isNotEmpty) {
      cartStore.productStores.forEach((element) {
        if (element.quantity > 0) {
          amount += element.quantity;
          totalItem += 1;
          totalPrice += element.quantity * element.productPrice;
        }
      });
    }

    return CartOverViewModel(
        amount: "$amount đơn vị - $totalItem sản phầm",
        totalPrice: totalPrice.formatDouble() + " VNĐ");
  }

  void filterProductsByProductStore() {
    if (cartStore.productStores.length > 0) {
      for (var currentProduct in _currentProducts) {
        bool isExistInCartStore = false;
        for (var productStore in cartStore.productStores) {
          if (currentProduct.productId == productStore.productId) {
            isExistInCartStore = true;
            _currentProducts[_currentProducts.indexOf(currentProduct)] =
                productStore;
            break;
          }
        }
        if (!isExistInCartStore && currentProduct.quantity > 0) {
          ProductStore productZeroQuantity =
              currentProduct.copyWith(quantity: 0);
          _currentProducts[_currentProducts.indexOf(currentProduct)] =
              productZeroQuantity;
        }
      }
    } else {
      if (_currentProducts.length > 0) {
        _currentProducts.forEach((element) {
          if (element.quantity > 0) {
            var newElement = element.copyWith(quantity: 0);
            _currentProducts[_currentProducts.indexOf(element)] = newElement;
          }
        });
      }
    }
  }

  void filterProductsByGroup(int groupID) {
    _currentProducts.clear();
    if (groupID == -1) {
      _currentProducts.addAll(_totalProducts);
    } else {
      _currentProducts.addAll(
          _totalProducts.where((element) => element.groupId == groupID));
    }
  }
}
