import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/home/product_category_home.dart';

part 'product_category_event.dart';

part 'product_category_state.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  GetListProductCategoriesHomeUseCase _useCase = GetIt.instance.get();

  ProductCategoryBloc() : super(ProductCategoryInit());

  @override
  Stream<ProductCategoryState> mapEventToState(
      ProductCategoryEvent event) async* {
    if (event is RequestProductCategoryEvent) {
      yield* _handleRequestListCategories();
    }
  }

  Stream<ProductCategoryState> _handleRequestListCategories() async* {
    yield ProductCategoryLoading();
    Either<Failure, ProductCategoriesHomeResults> result =
        await _useCase.execute(EmptyInput());
    if (result.isSuccess) {
      yield ProductCategorySuccess(
          productCategories: result.success.listProductCategory);
    } else {
      yield ProductCategoryError();
    }
  }
}
