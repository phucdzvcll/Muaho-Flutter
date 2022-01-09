import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

extension InjectStateExtension on State {
  T inject<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return GetIt.instance.get(
      param1: param1,
      instanceName: instanceName,
      param2: param2,
    );
  }
}

extension InjectWidgetExtension on Widget {
  T inject<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return GetIt.instance.get(
      param1: param1,
      instanceName: instanceName,
      param2: param2,
    );
  }
}

