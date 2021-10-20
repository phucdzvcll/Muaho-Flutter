import 'package:get_it/get_it.dart';
import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/models/slide_banner_entity.dart';
import 'package:muaho/domain/repository/home_page_repository.dart';

class GetListBannerUseCase extends BaseUseCase<EmptyInput, GetListBannerResult> {
  final HomePageRepository repository = GetIt.instance.get();

  @override
  Future<Either<Failure, GetListBannerResult>> executeInternal(
      EmptyInput input) async {
    return await repository.getListSlideBanner();
  }
}

class GetListBannerResult {
  final List<SlideBannerEntity> listBanner;

  GetListBannerResult({required this.listBanner});
}
