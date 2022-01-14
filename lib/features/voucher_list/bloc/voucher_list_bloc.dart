import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/voucher/voucher.dart';
import 'package:muaho/domain/use_case/voucher/get_voucher_list_use_case.dart';

part 'voucher_list_state.dart';
part 'voucher_list_event.dart';

class VoucherListBloc extends Bloc<VoucherListEvent, VoucherListState> {
  final GetVoucherListUseCase getVoucherListUseCase;

  VoucherListBloc({
    required this.getVoucherListUseCase,
  }) : super(VoucherListInitial()) {
    on<RequestVoucherListEvent>((event, emit) async {
      await _handleRequestVoucherListEvent(emit);
    });
  }

  Future _handleRequestVoucherListEvent(Emitter<VoucherListState> emit) async {
    emit(VoucherListLoadingState());

    Either<Failure, List<VoucherListItem>> result =
        await getVoucherListUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      List<VoucherListItem> voucherList = result.success;
      emit(
        VoucherListSuccessState(
          vouchers: voucherList,
        ),
      );
    } else {
      emit(
        VoucherListFailState(),
      );
    }
  }
}
