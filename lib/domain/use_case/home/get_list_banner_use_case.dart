import '../../domain.dart';

class GetListBannerUseCase extends BaseUseCase<EmptyInput, BannersResult> {
  final HomePageRepository homePageRepository;

  GetListBannerUseCase({required this.homePageRepository});

  @override
  Future<Either<Failure, BannersResult>> executeInternal(
      EmptyInput input) async {
    return await homePageRepository.getListSlideBanner();
  }
}

class BannersResult {
  final List<SlideBannerEntity> listBanner;

  BannersResult({required this.listBanner});
}
