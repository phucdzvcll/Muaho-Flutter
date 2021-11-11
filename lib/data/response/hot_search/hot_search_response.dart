import 'package:json_annotation/json_annotation.dart';

part 'hot_search_response.g.dart';

@JsonSerializable()
class HotSearchResponse {
  List<HotKeywordResponse>? keywords;
  List<HotShopResponse>? shops;

  factory HotSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$HotSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotSearchResponseToJson(this);

//<editor-fold desc="Data Methods">

  HotSearchResponse({
    required this.keywords,
    required this.shops,
  });

  @override
  String toString() {
    return 'HotSearchResponse{' +
        ' keywords: $keywords,' +
        ' shops: $shops,' +
        '}';
  }

//</editor-fold>
}

@JsonSerializable()
class HotKeywordResponse {
  final String? name;

  factory HotKeywordResponse.fromJson(Map<String, dynamic> json) =>
      _$HotKeywordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotKeywordResponseToJson(this);

//<editor-fold desc="Data Methods">

  const HotKeywordResponse({
    required this.name,
  });

  @override
  String toString() {
    return 'HotKeywordResponse{' + ' name: $name,' + '}';
  }
//</editor-fold>
}

@JsonSerializable()
class HotShopResponse {
  final int? id;
  final String? name;
  final String? address;
  final String? thumbUrl;

  factory HotShopResponse.fromJson(Map<String, dynamic> json) =>
      _$HotShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotShopResponseToJson(this);

//<editor-fold desc="Data Methods">

  const HotShopResponse({
    required this.id,
    required this.name,
    required this.address,
    required this.thumbUrl,
  });

  @override
  String toString() {
    return 'HotShopRespones{' +
        ' id: $id,' +
        ' name: $name,' +
        ' address: $address,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

//</editor-fold>
}
