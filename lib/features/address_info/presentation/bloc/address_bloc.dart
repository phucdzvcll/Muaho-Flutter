import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/address_info/domain/use_case/get_list_address_info_use_case.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetListAddressInfoUseCase getListAddressInfoUseCase;

  AddressBloc({
    required this.getListAddressInfoUseCase,
  }) : super(AddressInitial()) {
    on<RequestListAddressEvent>((event, emit) async {
      await _handleRequestListAddress(emit);
    });

    on<RefreshListAddressEvent>((event, emit) async {
      await _handleRequestListAddress(emit);
    });

    on<ChangeCurrentAddress>((event, emit) {
      emit(ChangeAddressSuccess(addressInfoEntity: event.addressInfoEntity));
    });
  }

  Future<void> _handleRequestListAddress(Emitter<AddressState> emit) async {
    Either<Failure, List<AddressInfoEntity>> execute =
        await getListAddressInfoUseCase.execute(EmptyInput());
    if (execute.isSuccess) {
      emit(GetListAddressSuccess(addressInfoEntities: execute.success));
    } else {
      emit(Error());
    }
  }
}
