import '../../domain.dart';

class GetListShopBySearchUseCase
    extends BaseUseCase<GetListShopBySearchParam, List<SearchShop>> {
  final SearchRepository searchRepository;

  GetListShopBySearchUseCase({required this.searchRepository});

  @override
  Future<Either<Failure, List<SearchShop>>> executeInternal(
      GetListShopBySearchParam input) async {
    return await searchRepository.getListShop(input.keyword);
  }
}

class GetListShopBySearchParam {
  final String keyword;

  GetListShopBySearchParam({required this.keyword});
}
