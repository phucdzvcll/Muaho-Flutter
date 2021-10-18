import '../domain.dart';

abstract class HomePageRepository {
  Future<Either<Failure, GetListBannerResult>> getListBanner();
}
