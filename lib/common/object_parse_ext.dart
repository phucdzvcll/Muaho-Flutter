class ObjectParseUtil {
  static num? parseNum(dynamic value) {
    if (value != null) {
      if (value is num) {
        return value;
      } else if (value is String) {
        return num.tryParse(value);
      }
    }
    return null;
  }

  static bool? parseBool(dynamic value) {
    if (value != null) {
      if (value is bool) {
        return value;
      } else if (value is String) {
        return value.toLowerCase() == "true";
      }
    }
    return null;
  }

  static int? parseInt(dynamic value) {
    return parseNum(value)?.toInt();
  }

  static double? parseDouble(dynamic value) {
    return parseNum(value)?.toDouble();
  }

  static String? parseString(dynamic value) {
    if (value != null) {
      if (value is String) {
        return value;
      } else {
        return value.toString();
      }
    }
    return null;
  }

  static DateTime? parseDatetime(dynamic value) {
    if (value != null) {
      if (value != null) {
        if (value is DateTime) {
          return value;
        } else if (value is String) {
          return DateTime.tryParse(value);
        }
      }
      return null;
    }
  }
}

extension JsonParseExtension on Map<String, dynamic> {
  DateTime? parseDatetime(String key) {
    dynamic object = this[key];
    return ObjectParseUtil.parseDatetime(object);
  }

  String? parseString(String key) {
    dynamic object = this[key];
    return ObjectParseUtil.parseString(object);
  }

  bool? parseBool(String key) {
    dynamic object = this[key];
    return ObjectParseUtil.parseBool(object);
  }

  num? parseNum(String key) {
    dynamic object = this[key];
    return ObjectParseUtil.parseNum(object);
  }

  int? parseInt(String key) {
    dynamic object = this[key];
    return ObjectParseUtil.parseInt(object);
  }

  double? parseDouble(String key) {
    dynamic object = this[key];
    return ObjectParseUtil.parseDouble(object);
  }

  List<String>? parseListString(String key, {required String defaultValue}) {
    dynamic object = this[key];
    if (object != null && object is List) {
      return object
          .map((value) => ObjectParseUtil.parseString(value) ?? defaultValue)
          .toList();
    }

    return null;
  }

  List<int>? parseListInt(String key, {required int defaultValue}) {
    dynamic object = this[key];
    if (object != null && object is List) {
      return object
          .map((value) => ObjectParseUtil.parseInt(value) ?? defaultValue)
          .toList();
    }

    return null;
  }

  List<double>? parseListDouble(String key, {required double defaultValue}) {
    dynamic object = this[key];
    if (object != null && object is List) {
      return object
          .map((value) => ObjectParseUtil.parseDouble(value) ?? defaultValue)
          .toList();
    }

    return null;
  }

  List<bool>? parseListBool(String key, {required bool defaultValue}) {
    dynamic object = this[key];
    if (object != null && object is List) {
      return object
          .map((value) => ObjectParseUtil.parseBool(value) ?? defaultValue)
          .toList();
    }

    return null;
  }

  List<T>? parseListObject<T>(
      String key, T Function(Map<String, dynamic> item) itemFromJson) {
    dynamic object = this[key];
    if (object != null && object is List) {
      return object.map((e) => itemFromJson(e)).toList();
    }

    return null;
  }

  T? parseObject<T>(
      String key, T Function(Map<String, dynamic> data) fromJson) {
    dynamic object = this[key];
    if (object != null) {
      return fromJson(object);
    }

    return null;
  }
}

class XX {
  void x() {
    dynamic num;

    num.parseString();
  }
}
