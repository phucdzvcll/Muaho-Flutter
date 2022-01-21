import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/address_info/domain/repo/address_infor_repository.dart';

class GetListAddressInfoUseCase
    extends BaseUseCase<EmptyInput, List<AddressInfoEntity>> {
  final AddressRepository repository;

  @override
  Future<Either<Failure, List<AddressInfoEntity>>> executeInternal(
      EmptyInput input) async {
    return await repository.getListAddressInfo();
  }

  GetListAddressInfoUseCase({
    required this.repository,
  });
}
