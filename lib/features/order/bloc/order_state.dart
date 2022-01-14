part of 'order_bloc.dart';

@immutable
abstract class OrderState extends Equatable {}

class OrderInitial extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderError extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderSuccess extends OrderState {
  final OrderDetailModel shopDetailModel;

  OrderSuccess({required this.shopDetailModel});

  @override
  List<Object?> get props => [shopDetailModel];
}

class WarningChangeShop extends OrderListenOnlyState {
  final ProductEntity productStore;

  WarningChangeShop({required this.productStore});

  @override
  List<Object?> get props => [productStore];
}

class WarningRemoveProduct extends OrderListenOnlyState {
  final int productID;

  WarningRemoveProduct({required this.productID});

  @override
  List<Object?> get props => [productID];
}

class OrderListenOnlyState extends OrderState {
  @override
  List<Object?> get props => [];
}
