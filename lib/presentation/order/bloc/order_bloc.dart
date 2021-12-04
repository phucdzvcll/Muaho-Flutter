import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/shop/get_shop_product_use_case.dart';
import 'package:muaho/presentation/order/model/cart_over_view_model.dart';
import 'package:muaho/presentation/order/model/order_detail_model.dart';
import 'package:muaho/presentation/order/model/product_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  GetShopProductUseCase _useCase = GetIt.instance.get();

  OrderBloc() : super(OrderInitial());

  List<OrderProduct> _totalProducts = [];
  List<OrderProduct> _currentProducts = [];
  List<OrderProduct> _orderProducts = [];

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
        shopDetailModel: OrderDetailModel(
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
      _totalProducts.addAll(result.success.products.map((e) => mapProduct(e)));
      _shopName = result.success.shopName;
      _address = result.success.shopAddress;
      _groups.addAll(result.success.groups);

      yield OrderSuccess(
          shopDetailModel: OrderDetailModel(
              cartOverView: createCartOverView(),
              currentGroupId: -1,
              shopName: _shopName,
              shopAddress: _address,
              groups: _groups,
              currentListProducts: _totalProducts));
    } else {
      yield OrderError();
    }
  }

  OrderProduct mapProduct(ProductEntity productEntity) {
    return OrderProduct(
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
        shopDetailModel: OrderDetailModel(
            currentGroupId: currentGroupId,
            shopName: _shopName,
            shopAddress: _address,
            groups: _groups,
            currentListProducts: _currentProducts,
            cartOverView: createCartOverView()));
  }

  CartOverViewModel createCartOverView() {
    _orderProducts.clear();
    int amount = 0;
    int totalItem = 0;
    double totalPrice = 0.0;

    if (_totalProducts.isNotEmpty) {
      _totalProducts.forEach((element) {
        if (element.amount > 0) {
          _orderProducts.add(element);
          amount += element.amount;
          totalItem += 1;
          totalPrice += element.amount * element.productPrice;
        }
      });
    }

    return CartOverViewModel(
        amount: "$amount đơn vị - $totalItem sản phầm",
        totalPrice: totalPrice.formatDouble() + " VNĐ",
        products: _totalProducts);
  }

  void replaceProduct(OrderProduct newProduct) {
    if (_totalProducts.isNotEmpty) {
      for (var product in _totalProducts) {
        if (product.productId == newProduct.productId) {
          _totalProducts[_totalProducts.indexOf(product)] = newProduct;
          break;
        }
      }
    }
  }

  void filterProducts(int groupID) {
    _currentProducts.clear();
    if (groupID == -1) {
      _currentProducts.addAll(_totalProducts);
    } else {
      _currentProducts.addAll(
          _totalProducts.where((element) => element.groupId == groupID));
    }
  }
}
