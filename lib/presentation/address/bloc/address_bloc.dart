import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetListAddressInfoUseCase getListAddressInfoUseCase;
  final CartUpdateBloc cartUpdateBloc;

  AddressBloc(
      {required this.getListAddressInfoUseCase, required this.cartUpdateBloc})
      : super(AddressInitial()) {
    on<RequestListAddressEvent>((event, emit) async {
      Either<Failure, List<AddressInfoEntity>> execute =
          await getListAddressInfoUseCase.execute(EmptyInput());
      if (execute.isSuccess) {
        emit(GetListAddressSuccess(addressInfoEntities: execute.success));
      } else {
        emit(Error());
      }
    });

    on<ChangeCurrentAddress>((event, emit) {
      cartUpdateBloc.cartStore.setAddressInfo(event.addressInfoEntity);
      emit(ChangeAddressSuccess());
    });
  }
}
