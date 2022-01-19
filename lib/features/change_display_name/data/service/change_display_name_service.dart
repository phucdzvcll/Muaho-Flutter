import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/features/change_display_name/data/response/display_name_response.dart';
import 'package:retrofit/http.dart';

part 'change_display_name_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ChangeDisplayNameService {
  factory ChangeDisplayNameService(Dio dio) = _ChangeDisplayNameService;

  @POST("/user/update/username")
  Future<DisplayNameResponse> changeDisplayName(
      @Body() ChangeDisplayNameParam displayName);
}

class ChangeDisplayNameParam extends Equatable {
  final String? userName;

  ChangeDisplayNameParam({
    this.userName,
  });

  factory ChangeDisplayNameParam.fromJson(Map<String, dynamic> json) {
    return ChangeDisplayNameParam(
      userName: json.parseString('user_name'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_name'] = userName;
    return data;
  }

  @override
  List<Object?> get props => [
        userName,
      ];
}
