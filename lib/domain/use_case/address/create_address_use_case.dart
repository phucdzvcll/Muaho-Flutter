import 'package:muaho/domain/domain.dart';

class CreateAddressUseCase
    extends BaseUseCase<AddressInfoEntity, CreateAddressResult> {
  final AddressRepository addressInfoRepository;

  @override
  Future<Either<Failure, CreateAddressResult>> executeInternal(
      AddressInfoEntity input) async {
    return addressInfoRepository.createAddress(input);
  }

  CreateAddressUseCase({
    required this.addressInfoRepository,
  });
}
