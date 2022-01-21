import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class HotSearchResponse extends Equatable {
  final List<HotKeywordResponse>? keywords;
  final List<HotShopResponse>? shops;

  HotSearchResponse({
    this.keywords,
    this.shops,
  });

  factory HotSearchResponse.fromJson(Map<String, dynamic> json) {
    return HotSearchResponse(
      keywords: json.parseListObject('keywords', HotKeywordResponse.fromJson),
      shops: json.parseListObject('shops', HotShopResponse.fromJson),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (keywords != null) {
      data['keywords'] = keywords?.map((v) => v.toJson()).toList();
    }
    if (shops != null) {
      data['shops'] = shops?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        keywords,
        shops,
      ];
}

class HotKeywordResponse extends Equatable {
  final String? name;

  HotKeywordResponse({
    this.name,
  });

  factory HotKeywordResponse.fromJson(Map<String, dynamic> json) {
    return HotKeywordResponse(
      name: json.parseString('name'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [
        name,
      ];
}

class HotShopResponse extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final String? thumbUrl;

  HotShopResponse({
    this.id,
    this.name,
    this.address,
    this.thumbUrl,
  });

  factory HotShopResponse.fromJson(Map<String, dynamic> json) {
    return HotShopResponse(
      id: json.parseInt('id'),
      name: json.parseString('name'),
      address: json.parseString('address'),
      thumbUrl: json.parseString('thumbUrl'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['thumbUrl'] = thumbUrl;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        thumbUrl,
      ];
}
