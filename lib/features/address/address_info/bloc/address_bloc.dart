import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';

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
