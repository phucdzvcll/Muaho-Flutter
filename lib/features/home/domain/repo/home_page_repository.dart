import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/home/domain/use_case/home/get_list_banner_use_case.dart';
import 'package:muaho/features/home/domain/use_case/home/get_list_product_categories_home_use_case.dart';

abstract class HomePageRepository {
  Future<Either<Failure, BannersResult>> getListSlideBanner();

  Future<Either<Failure, ProductCategoriesHomeResults>>
      getListProductCategoriesHome();
}
