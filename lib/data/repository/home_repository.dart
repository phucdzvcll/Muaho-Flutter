import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/data/data.dart';

class HomeRepositoryImpl implements HomePageRepository {
  @override
  Future<Either<Failure, GetListBannerResult>> getListSlideBanner() async {
    HomeService homeService = GetIt.instance.get();
    var requestGetSlideBanner = homeService.getSlideBanners();
    var result = await handleNetworkResult(requestGetSlideBanner);
    if (result.isSuccess()) {
      List<SlideBannerEntity> slideBanner = [];
      result.response?.forEach((element) {
        var banner = SlideBannerEntity(
            id: element.id.defaultZero(),
            subject: element.subject.defaultEmpty(),
            description: element.description.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty());
        slideBanner.add(banner);
      });
      return SuccessValue(GetListBannerResult(listBanner: slideBanner));
    } else {
      return FailValue(Failure());
    }
  }
}
