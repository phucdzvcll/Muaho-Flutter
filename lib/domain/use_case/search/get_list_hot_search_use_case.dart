import 'package:get_it/get_it.dart';
import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/models/search/hot_keyword.dart';
import 'package:muaho/domain/models/search/hot_shop.dart';
import 'package:muaho/domain/repository/search_page_repository.dart';

class GetHotSearchUseCase extends BaseUseCase<EmptyInput, HostSearchResult> {
  final SearchPageRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, HostSearchResult>> executeInternal(
      EmptyInput input) async {
    return await repository.getListHotSearch();
  }
}

class HostSearchResult {
  final List<HotKeyword> listHotKeywords;
  final List<HotShop> listHotShop;

  HostSearchResult({required this.listHotKeywords, required this.listHotShop});
}
