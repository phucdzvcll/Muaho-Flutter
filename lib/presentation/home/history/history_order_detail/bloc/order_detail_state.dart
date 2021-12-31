part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailState extends Equatable {}

class OrderDetailInitial extends OrderDetailState {
  @override
  List<Object?> get props => [];
}

class OrderDetailLoading extends OrderDetailState {
  @override
  List<Object?> get props => [];
}

class OrderDetailError extends OrderDetailState {
  @override
  List<Object?> get props => [];
}

class OrderDetailSuccess extends OrderDetailState {
  final OrderDetailSuccessModel orderDetailSuccessModel;

  OrderDetailSuccess({required this.orderDetailSuccessModel});

  @override
  List<Object?> get props => [orderDetailSuccessModel];
}

class OrderDetailSuccessModel extends Equatable {
  final OrderDetailEntity entity;
  final CartSummary cartInfo;

  OrderDetailSuccessModel({required this.entity, required this.cartInfo});

  @override
  List<Object?> get props => [entity, cartInfo];
}
