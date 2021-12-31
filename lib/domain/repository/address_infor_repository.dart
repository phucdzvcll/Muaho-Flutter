import 'package:muaho/domain/domain.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressInfoEntity>>> getListAddressInfo();

  Future<Either<Failure, CreateAddressResult>> createAddress(
      AddressInfoEntity addressInfoEntity);
}
