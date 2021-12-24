part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailState {}

class OrderDetailInitial extends OrderDetailState {}

class OrderDetailLoading extends OrderDetailState {}

class OrderDetailError extends OrderDetailState {}

class OrderDetailSuccess extends OrderDetailState {
  final OrderDetailSuccessModel orderDetailSuccessModel;

  OrderDetailSuccess({required this.orderDetailSuccessModel});
}

class OrderDetailSuccessModel {
  final OrderDetailEntity entity;
  final CartOverViewModel cartOverViewModel;

  OrderDetailSuccessModel(
      {required this.entity, required this.cartOverViewModel});
}
