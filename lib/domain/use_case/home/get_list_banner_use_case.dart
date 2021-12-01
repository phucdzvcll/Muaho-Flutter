import 'package:get_it/get_it.dart';

import '../../domain.dart';

class GetListBannerUseCase extends BaseUseCase<EmptyInput, BannersResult> {
  final HomePageRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, BannersResult>> executeInternal(
      EmptyInput input) async {
    return await repository.getListSlideBanner();
  }
}

class BannersResult {
  final List<SlideBannerEntity> listBanner;

  BannersResult({required this.listBanner});
}
