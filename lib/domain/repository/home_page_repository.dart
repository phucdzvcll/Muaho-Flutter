import 'package:flutter/cupertino.dart';

import '../domain.dart';

abstract class HomePageRepository {
  Future<Either<Failure, BannersResult>> getListSlideBanner(
      {required String token});

  Future<Either<Failure, ProductCategoriesHomeResults>>
      getListProductCategoriesHome();
}
