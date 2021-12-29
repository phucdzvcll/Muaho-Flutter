import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/models/address/address_entity.dart';

abstract class AddressInfoRepository {
  Future<Either<Failure, List<AddressInfoEntity>>> getListAddressInfo();
}
