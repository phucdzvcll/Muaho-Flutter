import 'package:get_it/get_it.dart';

import '../../domain.dart';

class GetHotSearchUseCase extends BaseUseCase<EmptyInput, HostSearchResult> {
  final SearchRepository repository = GetIt.instance.get();

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
