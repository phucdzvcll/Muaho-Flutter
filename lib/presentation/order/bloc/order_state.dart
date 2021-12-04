part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderError extends OrderState {}

class OrderSuccess extends OrderState {
  final OrderDetailModel shopDetailModel;

  OrderSuccess({required this.shopDetailModel});
}
