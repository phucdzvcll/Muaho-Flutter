import 'package:get_it/get_it.dart';

import '../../domain.dart';

class GetListBannerUseCase extends BaseUseCase<GetBannerParam, BannersResult> {
  final HomePageRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, BannersResult>> executeInternal(
      GetBannerParam input) async {
    return await repository.getListSlideBanner(token: input.token);
  }
}

class GetBannerParam {
  final String token;

  GetBannerParam({required this.token});
}

class BannersResult {
  final List<SlideBannerEntity> listBanner;

  BannersResult({required this.listBanner});
}
