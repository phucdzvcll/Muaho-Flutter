import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class DisplayNameResponse extends Equatable {
  final String? userName;

  DisplayNameResponse({
    this.userName,
  });

  factory DisplayNameResponse.fromJson(Map<String, dynamic> json) {
    return DisplayNameResponse(
      userName: json.parseString('userName'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userName'] = userName;
    return data;
  }

  @override
  List<Object?> get props => [
        userName,
      ];
}
