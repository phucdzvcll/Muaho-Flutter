import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/create_address/domain/models/create_address_result.dart';
import 'package:muaho/features/create_address/domain/repo/create_address_repository.dart';

class CreateAddressUseCase
    extends BaseUseCase<AddressInfoEntity, CreateAddressResult> {
  final CreateAddressRepository createAddressRepository;

  @override
  Future<Either<Failure, CreateAddressResult>> executeInternal(
      AddressInfoEntity input) async {
    return createAddressRepository.createAddress(input);
  }

  CreateAddressUseCase({
    required this.createAddressRepository,
  });
}
