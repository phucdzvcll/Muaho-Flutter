import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class CreateAddressBody extends Equatable {
  final String? address;
  final String? contactPhoneNumber;
  final double? lat;
  final double? lng;

  CreateAddressBody({
    this.address,
    this.contactPhoneNumber,
    this.lat,
    this.lng,
  });

  factory CreateAddressBody.fromJson(Map<String, dynamic> json) {
    return CreateAddressBody(
      address: json.parseString('address'),
      contactPhoneNumber: json.parseString('contact_phone_number'),
      lat: json.parseDouble('lat'),
      lng: json.parseDouble('lng'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['address'] = address;
    data['contact_phone_number'] = contactPhoneNumber;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  @override
  List<Object?> get props => [
        address,
        contactPhoneNumber,
        lat,
        lng,
      ];
}
