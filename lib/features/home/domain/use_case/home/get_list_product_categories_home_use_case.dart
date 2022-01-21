import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/home/domain/models/home/product_category_home.dart';
import 'package:muaho/features/home/domain/repo/home_page_repository.dart';

class GetListProductCategoriesHomeUseCase
    extends BaseUseCase<EmptyInput, ProductCategoriesHomeResults> {
  final HomePageRepository homePageRepository;

  GetListProductCategoriesHomeUseCase({required this.homePageRepository});

  @override
  Future<Either<Failure, ProductCategoriesHomeResults>> executeInternal(
      EmptyInput input) async {
    return await homePageRepository.getListProductCategoriesHome();
  }
}

class ProductCategoriesHomeResults {
  final List<ProductCategoryHomeEntity> listProductCategory;

  ProductCategoriesHomeResults({required this.listProductCategory});
}
