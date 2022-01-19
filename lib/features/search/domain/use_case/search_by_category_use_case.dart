import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/search/domain/models/search_shop/search_shop_by_category.dart';
import 'package:muaho/features/search/domain/repo/search_repository.dart';

class SearchShopByCategoryUseCase
    extends BaseUseCase<SearchShopByCategoryParam, SearchShopByCategoryEntity> {
  final SearchRepository searchRepository;

  SearchShopByCategoryUseCase({required this.searchRepository});

  @override
  Future<Either<Failure, SearchShopByCategoryEntity>> executeInternal(
      SearchShopByCategoryParam input) async {
    return await searchRepository.getListShopByCategory(input.categoryID);
  }
}

class SearchShopByCategoryParam {
  final int categoryID;

  SearchShopByCategoryParam({required this.categoryID});
}
