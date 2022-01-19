import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/home/domain/models/home/slide_banner_entity.dart';
import 'package:muaho/features/home/domain/repo/home_page_repository.dart';

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
