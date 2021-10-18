import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/models/banner.dart';
import 'package:muaho/domain/repository/HomePageRepository.dart';

class GetListBanner extends BaseUseCase<EmptyInput, GetListBannerResult> {
  final HomePageRepository repository;

  GetListBanner({required this.repository});

  @override
  Future<Either<Failure, GetListBannerResult>> executeInternal(
      EmptyInput input) async {
    return await repository.getListBanner();
  }
}

class GetListBannerResult {
  final List<Banner> listBanner;

  GetListBannerResult({required this.listBanner});
}
