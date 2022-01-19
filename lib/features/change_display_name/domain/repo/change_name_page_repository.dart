import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/change_display_name/domain/models/display_name_entity.dart';

abstract class ChangeNameRepository {
  Future<Either<Failure, DisplayNameEntity>> changeDisplayName(
      String displayName);
}
