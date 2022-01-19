import 'package:equatable/equatable.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/change_display_name/domain/models/display_name_entity.dart';
import 'package:muaho/features/change_display_name/domain/repo/change_name_page_repository.dart';

class ChangeDisplayNameUseCase
    extends BaseUseCase<ChangeDisplayNameParam, DisplayNameEntity> {
  final ChangeNameRepository settingPageRepository;

  ChangeDisplayNameUseCase({
    required this.settingPageRepository,
  });

  @override
  Future<Either<Failure, DisplayNameEntity>> executeInternal(
      ChangeDisplayNameParam input) async {
    return await settingPageRepository.changeDisplayName(input.displayName);
  }
}

class ChangeDisplayNameParam extends Equatable {
  final String displayName;

  const ChangeDisplayNameParam({
    required this.displayName,
  });

  @override
  List<Object?> get props => [displayName];
}
