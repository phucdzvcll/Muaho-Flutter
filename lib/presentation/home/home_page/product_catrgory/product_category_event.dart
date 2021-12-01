part of 'product_category_bloc.dart';

@immutable
abstract class ProductCategoryEvent {}

class RequestProductCategoryEvent extends ProductCategoryEvent {
  final String token;

  RequestProductCategoryEvent({required this.token});
}
