import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/voucher_list/domain/models/voucher.dart';
import 'package:muaho/features/voucher_list/domain/use_case/get_voucher_list_use_case.dart';

part 'voucher_list_event.dart';
part 'voucher_list_state.dart';

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
