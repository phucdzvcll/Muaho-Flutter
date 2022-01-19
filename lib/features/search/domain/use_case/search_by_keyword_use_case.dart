import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/search/domain/models/search_shop/seach_shop_by_keyword.dart';
import 'package:muaho/features/search/domain/repo/search_repository.dart';

class SearchShopByKeywordUseCase extends BaseUseCase<GetListShopBySearchParam,
    List<SearchShopByKeywordEntity>> {
  final SearchRepository searchRepository;

  SearchShopByKeywordUseCase({required this.searchRepository});

  @override
  Future<Either<Failure, List<SearchShopByKeywordEntity>>> executeInternal(
      GetListShopBySearchParam input) async {
    return await searchRepository.getListShopByKeyword(input.keyword);
  }
}

class GetListShopBySearchParam {
  final String keyword;

  GetListShopBySearchParam({required this.keyword});
}
