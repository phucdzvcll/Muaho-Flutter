import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/address_info/data/response/address_info_response.dart';
import 'package:muaho/features/address_info/data/services/address_service.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/address_info/domain/repo/address_infor_repository.dart';

class AddressInfoRepositoryImpl implements AddressRepository {
  final AddressService service;

  AddressInfoRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, List<AddressInfoEntity>>> getListAddressInfo() async {
    NetworkResult<List<AddressInfoResponse>> result =
        await handleNetworkResult(service.getListAddressInfo());
    if (result.isSuccess()) {
      return SuccessValue((result.response).defaultEmpty().map((e) {
        AddressInfoResponse response = e;
        return AddressInfoEntity(
          id: response.id.defaultZero(),
          contactPhoneNumber: response.contactPhoneNumber.defaultEmpty(),
          address: response.address.defaultEmpty(),
          lat: response.lat.defaultZero(),
          lng: response.lng.defaultZero(),
        );
      }).toList());
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }
}
