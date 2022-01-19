import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/change_display_name/data/service/change_display_name_service.dart';
import 'package:muaho/features/change_display_name/domain/models/display_name_entity.dart';
import 'package:muaho/features/change_display_name/domain/repo/change_name_page_repository.dart';

class ChangeNameRepositoryImpl extends ChangeNameRepository {
  final ChangeDisplayNameService service;
  final UserStore userStore;

  ChangeNameRepositoryImpl({required this.service, required this.userStore});

  @override
  Future<Either<Failure, DisplayNameEntity>> changeDisplayName(
      String displayName) async {
    var result = await handleNetworkResult(service
        .changeDisplayName(ChangeDisplayNameParam(userName: displayName)));
    if (result.isSuccess()) {
      String newDisplayName = (result.response?.userName).defaultEmpty();
      await userStore.setUseName(newDisplayName);
      return SuccessValue(
        DisplayNameEntity(
          displayName: newDisplayName,
        ),
      );
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }
}
