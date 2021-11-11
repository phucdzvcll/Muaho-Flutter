import 'package:get_it/get_it.dart';
import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/models/home/product_category_home.dart';
import 'package:muaho/domain/repository/home_page_repository.dart';

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
