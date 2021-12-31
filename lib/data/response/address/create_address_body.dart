import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_address_body.g.dart';

@JsonSerializable()
class CreateAddressBody extends Equatable {
  final String address;
  @JsonKey(name: "contact_phone_number")
  final String phoneNumber;
  final double lat;
  final double lng;

  const CreateAddressBody({
    required this.address,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
  });

  factory CreateAddressBody.fromJson(Map<String, dynamic> json) =>
      _$CreateAddressBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAddressBodyToJson(this);

  @override
  List<Object?> get props => [address, phoneNumber, lat, lng];
}
