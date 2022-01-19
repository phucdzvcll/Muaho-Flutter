import 'package:muaho/features/home/domain/models/home/product_category_home.dart';
import 'package:muaho/features/home/domain/models/home/slide_banner_entity.dart';

class HomePageModel {
  final List<ProductCategoryHomeEntity> productCategories;
  final List<SlideBannerEntity> slideBannerEntity;

  const HomePageModel(
      {required this.productCategories, required this.slideBannerEntity});
}
