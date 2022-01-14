part of 'voucher_list_bloc.dart';

abstract class VoucherListState extends Equatable {
  const VoucherListState();
}

class VoucherListInitial extends VoucherListState {
  @override
  List<Object> get props => [];
}

class VoucherListSuccessState extends VoucherListState {
  final List<VoucherListItem> vouchers;

  @override
  List<Object> get props => [vouchers];

  const VoucherListSuccessState({
    required this.vouchers,
  });
}


class VoucherListFailState extends VoucherListState {
  @override
  List<Object> get props => [];
}

class VoucherListLoadingState extends VoucherListState {
  @override
  List<Object> get props => [];
}