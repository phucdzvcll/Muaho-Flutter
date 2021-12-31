part of 'cart_update_bloc.dart';

@immutable
abstract class CartUpdateState extends Equatable {}

class CartUpdateInitial extends CartUpdateState {
  @override
  List<Object?> get props => [];
}

class CartUpdatedState extends CartUpdateState {
  final CartInfo cartInfo;

  CartUpdatedState({required this.cartInfo});

  @override
  List<Object?> get props => [cartInfo];
}
