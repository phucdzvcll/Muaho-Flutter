part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class RequestCartEvent extends CartEvent {}

class EditCartEvent extends CartEvent {
  final ProductStore productStore;

  EditCartEvent({required this.productStore});
}
