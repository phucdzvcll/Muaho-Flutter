import '../../domain.dart';

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
