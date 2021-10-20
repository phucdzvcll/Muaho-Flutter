import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:muaho/data/wrapped_response.dart';

part 'slide_banner_response.g.dart';

@JsonSerializable()
class SlideBannerResponse extends WrappedResponse {
  SlideBannerResponse();

//<editor-fold desc="Data Methods">

  //List<dynamic> parsedListJson = jsonDecode("data");

  //List<Data> data =
  //    List<Data>.from(parsedListJson.map((i) => Data.fromJson(i)));

//</editor-fold>
}

@JsonSerializable()
class Data {
  final int? id;
  final String? subject;
  final String? description;
  final String? thumbUrl;

//<editor-fold desc="Data Methods">
  @override
  String toString() {
    return 'Data{id: $id, subject: $subject, description: $description, thumbUrl: $thumbUrl}';
  }

  const Data({
    required this.id,
    required this.subject,
    required this.description,
    required this.thumbUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

//</editor-fold>
}
