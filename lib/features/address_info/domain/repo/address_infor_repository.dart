import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressInfoEntity>>> getListAddressInfo();
}
