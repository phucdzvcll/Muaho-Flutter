import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/features/login/presentation/bloc/login_bloc.dart';
import 'package:muaho/features/payment/domain/models/order_status_result.dart';
import 'package:muaho/features/payment/domain/models/payment_entity.dart';
import 'package:muaho/features/payment/domain/use_case/create_order_use_case.dart';
import 'package:muaho/features/payment/presentation/model/payment_info.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CartUpdateBloc cartUpdateBloc;
  final CreateOrderUseCase createOrderUseCase;
  final AppEventBus appEventBus;
  final FirebaseAuth firebaseAuth;
  bool isAnonymous = false;
  StreamSubscription<LoginSuccessEventBus>? loginSuccessListener;

  PaymentBloc({
    required this.createOrderUseCase,
    required this.cartUpdateBloc,
    required this.appEventBus,
    required this.firebaseAuth,
  }) : super(PaymentInitial()) {
    isAnonymous = firebaseAuth.currentUser != null &&
        (firebaseAuth.currentUser?.isAnonymous ?? false);

    loginSuccessListener =
        appEventBus.on<LoginSuccessEventBus>().listen((event) {
      this.add(CheckSignInEvent());
    });

    on<CreateOrderEvent>((event, emit) async {
      await _handleCreateOrderEvent(event, emit);
    });
    on<UpdateAddressEvent>((event, emit) async {
      await _handleUpdateAddressEvent(event);
    });

    on<CheckSignInEvent>((event, emit) async {
      isAnonymous = firebaseAuth.currentUser != null &&
          (firebaseAuth.currentUser?.isAnonymous ?? false);
      emit(
        SignInState(isSignIn: !isAnonymous),
      );
    });
  }

  Future<void> _handleCreateOrderEvent(
      CreateOrderEvent event, Emitter<PaymentState> emit) async {
    if (event.paymentEntity.productEntities.isNotEmpty) {
      Either<Failure, OrderStatusResult> result =
          await createOrderUseCase.execute(event.paymentEntity);
      emit(CreatingOrder());
      if (result.isSuccess) {
        appEventBus.fireEvent(CreateOrderSuccessEventBus());
        cartUpdateBloc.cartStore.createOrderSuccess();
        await Future.delayed(Duration(seconds: 1));
        emit(CreateOrderSuccess(orderId: result.success.orderID));
      } else {
        emit(CreateOrderFailed());
      }
    }
  }

  Future<void> _handleUpdateAddressEvent(UpdateAddressEvent event) async {
    cartUpdateBloc.cartStore.updateAddressInfo(event.addressInfoEntity);
  }

  @override
  Future<void> close() {
    loginSuccessListener?.cancel();
    return super.close();
  }
}

class CreateOrderSuccessEventBus extends AppEvent {
  @override
  List<Object?> get props => [];
}
