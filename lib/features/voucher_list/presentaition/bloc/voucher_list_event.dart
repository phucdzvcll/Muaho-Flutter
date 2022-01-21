part of 'voucher_list_bloc.dart';

abstract class VoucherListEvent extends Equatable {
  const VoucherListEvent();
}


class RequestVoucherListEvent extends VoucherListEvent {
  const RequestVoucherListEvent();

  @override
  List<Object?> get props => [];
}