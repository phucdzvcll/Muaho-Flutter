import 'package:muaho/domain/models/voucher/voucher.dart';
import 'package:muaho/domain/repository/user_repository.dart';

import '../../domain.dart';

class GetVoucherListUseCase
    extends BaseUseCase<EmptyInput, List<VoucherListItem>> {
  final UserRepository userRepository;

  GetVoucherListUseCase({required this.userRepository});

  @override
  Future<Either<Failure, List<VoucherListItem>>> executeInternal(
      EmptyInput input) async {
    return await userRepository.getVoucherList();
  }
}
