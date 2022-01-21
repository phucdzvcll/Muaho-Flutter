import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/create_address/domain/models/create_address_result.dart';

abstract class CreateAddressRepository {
  Future<Either<Failure, CreateAddressResult>> createAddress(
      AddressInfoEntity addressInfoEntity);
}
