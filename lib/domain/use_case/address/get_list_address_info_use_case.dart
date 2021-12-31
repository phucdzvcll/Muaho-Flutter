import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/models/address/address_entity.dart';
import 'package:muaho/domain/repository/address_infor_repository.dart';

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
