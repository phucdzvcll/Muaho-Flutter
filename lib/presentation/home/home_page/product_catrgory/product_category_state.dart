part of 'product_category_bloc.dart';

@immutable
abstract class ProductCategoryState {}

class ProductCategoryInit extends ProductCategoryState {}
class ProductCategoryLoading extends ProductCategoryState {}

class ProductCategorySuccess extends ProductCategoryState {
  final List<ProductCategoryHomeEntity> productCategories;

  ProductCategorySuccess({required this.productCategories});
}

class ProductCategoryError extends ProductCategoryState {}
