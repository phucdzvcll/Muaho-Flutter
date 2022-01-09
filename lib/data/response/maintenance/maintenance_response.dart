import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'maintenance_response.g.dart';

@JsonSerializable()
class MaintenanceResponse extends Equatable {
  final int? totalMinutes;

  @override
  List<Object?> get props => [totalMinutes];

  MaintenanceResponse({
    this.totalMinutes,
  });

  factory MaintenanceResponse.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceResponseToJson(this);
}
