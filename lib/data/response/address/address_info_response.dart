import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class AddressInfoResponse extends Equatable {
  final int? id;
  final String? contactPhoneNumber;
  final String? address;
  final double? lat;
  final double? lng;
  final String? createDate;

  AddressInfoResponse({
    this.id,
    this.contactPhoneNumber,
    this.address,
    this.lat,
    this.lng,
    this.createDate,
  });

  factory AddressInfoResponse.fromJson(Map<String, dynamic> json) {
    return AddressInfoResponse(
      id: json.parseInt('id'),
      contactPhoneNumber: json.parseString('contact_phone_number'),
      address: json.parseString('address'),
      lat: json.parseDouble('lat'),
      lng: json.parseDouble('lng'),
      createDate: json.parseString('create_date'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['contact_phone_number'] = contactPhoneNumber;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['create_date'] = createDate;
    return data;
  }

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
