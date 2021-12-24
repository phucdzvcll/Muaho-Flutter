import '../../domain.dart';

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
