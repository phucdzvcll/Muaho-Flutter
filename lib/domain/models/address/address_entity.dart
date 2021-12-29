import 'package:equatable/equatable.dart';

class AddressInfoEntity extends Equatable {
  final int id;
  final String contactPhoneNumber;
  final String address;
  final double lat;
  final double lng;
  final String createDate;

  const AddressInfoEntity({
    required this.id,
    required this.contactPhoneNumber,
    required this.address,
    required this.lat,
    required this.lng,
    required this.createDate,
  });

  @override
  List<Object?> get props => [
        id,
        contactPhoneNumber,
        address,
        lat,
        lng,
        createDate,
      ];
}
