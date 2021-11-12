import 'package:get_it/get_it.dart';

import '../../domain.dart';

class GetListProductCategoriesHomeUseCase
    extends BaseUseCase<EmptyInput, ProductCategoriesHomeResults> {
  final HomePageRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, ProductCategoriesHomeResults>> executeInternal(
      EmptyInput input) async {
    return await repository.getListProductCategoriesHome();
  }
}

class ProductCategoriesHomeResults {
  final List<ProductCategoryHomeEntity> listProductCategory;

  ProductCategoriesHomeResults({required this.listProductCategory});
}
