import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/create_address/data/response/create_address_body.dart';
import 'package:muaho/features/create_address/data/services/create_address_service.dart';
import 'package:muaho/features/create_address/domain/models/create_address_result.dart';
import 'package:muaho/features/create_address/domain/repo/create_address_repository.dart';

class CreateAddressInfoRepositoryImpl implements CreateAddressRepository {
  final CreateAddressService service;

  CreateAddressInfoRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, CreateAddressResult>> createAddress(
      addressEntity) async {
    NetworkResult result = await handleNetworkResult(
      service.createAddress(
        CreateAddressBody(
          address: addressEntity.address,
          lng: addressEntity.lng,
          lat: addressEntity.lat,
          contactPhoneNumber: addressEntity.contactPhoneNumber,
        ),
      ),
    );

    if (result.isSuccess()) {
      return SuccessValue(CreateAddressResult(status: Status.Success));
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }
}
