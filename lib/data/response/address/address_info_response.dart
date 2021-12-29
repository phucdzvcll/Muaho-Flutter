import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_info_response.g.dart';

@JsonSerializable()
class AddressInfoResponse extends Equatable {
  final int? id;
  @JsonKey(name: "contact_phone_number")
  final String? contactPhoneNumber;
  final String? address;
  final double? lat;
  final double? lng;
  @JsonKey(name: "create_date")
  final DateTime? createDate;

  AddressInfoResponse({
    this.id,
    this.contactPhoneNumber,
    this.address,
    this.lat,
    this.lng,
    this.createDate,
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

  factory AddressInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInfoResponseToJson(this);
}
