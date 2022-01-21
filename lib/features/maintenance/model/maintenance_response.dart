import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class MaintenanceResponse extends Equatable {
  final int? totalMinutes;

  MaintenanceResponse({
    this.totalMinutes,
  });

  factory MaintenanceResponse.fromJson(Map<String, dynamic> json) {
    return MaintenanceResponse(
      totalMinutes: json.parseInt('totalMinutes'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['totalMinutes'] = totalMinutes;
    return data;
  }

  @override
  List<Object?> get props => [
        totalMinutes,
      ];
}
