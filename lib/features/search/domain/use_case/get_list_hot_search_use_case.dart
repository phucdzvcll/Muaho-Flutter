import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/search/domain/models/hot_search/hot_keyword.dart';
import 'package:muaho/features/search/domain/models/hot_search/hot_shop.dart';
import 'package:muaho/features/search/domain/repo/search_repository.dart';

class GetHotSearchUseCase extends BaseUseCase<EmptyInput, HostSearchResult> {
  final SearchRepository searchRepository;

  GetHotSearchUseCase({required this.searchRepository});

  @override
  Future<Either<Failure, HostSearchResult>> executeInternal(
      EmptyInput input) async {
    return await searchRepository.getListHotSearch();
  }
}

class HostSearchResult {
  final List<HotKeyword> listHotKeywords;
  final List<HotShop> listHotShop;

  HostSearchResult({required this.listHotKeywords, required this.listHotShop});
}
