import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/domain/domain.dart';

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
      return FailValue(Failure());
    }
  }

  @override
  Future<Either<Failure, CreateAddressResult>> createAddress(
      addressEntity) async {
    NetworkResult createAddress = await handleNetworkResult(
      service.createAddress(
        CreateAddressBody(
          address: addressEntity.address,
          lng: addressEntity.lng,
          lat: addressEntity.lat,
          phoneNumber: addressEntity.contactPhoneNumber,
        ),
      ),
    );

    if (createAddress.isSuccess()) {
      return SuccessValue(CreateAddressResult(status: Status.Success));
    } else {
      return FailValue(Failure());
    }
  }
}
