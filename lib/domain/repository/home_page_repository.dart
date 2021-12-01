import '../domain.dart';

abstract class HomePageRepository {
  Future<Either<Failure, BannersResult>> getListSlideBanner();

  Future<Either<Failure, ProductCategoriesHomeResults>>
      getListProductCategoriesHome();
}
