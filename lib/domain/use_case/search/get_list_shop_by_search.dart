import 'package:get_it/get_it.dart';

import '../../domain.dart';

class GetListShopBySearchUseCase
    extends BaseUseCase<GetListShopBySearchParam, List<SearchShop>> {
  final SearchRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, List<SearchShop>>> executeInternal(
      GetListShopBySearchParam input) async {
    return await repository.getListShop(input.keyword);
  }
}

class GetListShopBySearchParam {
  final String keyword;

  GetListShopBySearchParam({required this.keyword});
}
