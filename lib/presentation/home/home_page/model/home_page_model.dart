import 'package:muaho/domain/domain.dart';

class HomePageModel {
  final List<ProductCategoryHomeEntity> productCategories;
  final List<SlideBannerEntity> slideBannerEntity;

  const HomePageModel(
      {required this.productCategories, required this.slideBannerEntity});
}
