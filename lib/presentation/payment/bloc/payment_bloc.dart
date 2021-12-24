import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/domain/use_case/order/create_oreder_use_case.dart';
import 'package:muaho/presentation/payment/model/payment_info.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({required this.cartStore, required this.createOrderUseCase})
      : super(PaymentInitial());
  String _userAddress = "";
  final CartStore cartStore;
  final CreateOrderUseCase createOrderUseCase;

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is RequestLocationPermission) {
      yield* _handleRequestPermission();
    } else if (event is CreateOrderEvent) {
      yield* _handleCreateOrder();
    }
  }

  Stream<PaymentState> _handleRequestPermission() async* {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var permission;
    if (serviceEnabled) {
      await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        yield GetLocationFailed();
      } else if (permission == LocationPermission.deniedForever) {
        yield GetLocationFailed();
      } else {
        try {
          final _location = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          List<Placemark> address = await placemarkFromCoordinates(
              _location.latitude, _location.longitude);
          _userAddress = address[0].street.defaultEmpty() +
              ", " +
              address[0].subAdministrativeArea.defaultEmpty() +
              ", " +
              address[0].administrativeArea.defaultEmpty();
          log(address.toString());
          log(_location.latitude.toString() +
              " " +
              _location.longitude.toString());
          yield GetPaymentInfoSuccess(
              paymentInfoModel: PaymentInfoModel(
                  userInfo: UserInfo(phoneNumber: "", address: _userAddress),
                  cartStore: cartStore,
                  total: calculatorTotal()));
        } on Exception catch (e) {
          yield GetLocationFailed();
        }
      }
    } else {
      yield GetLocationFailed();
    }
  }

  double calculatorTotal() {
    double total = 0;
    cartStore.productStores.forEach((element) {
      total += element.productPrice * element.quantity;
    });
    return total;
  }

  Stream<PaymentState> _handleCreateOrder() async* {
    var result = await createOrderUseCase.execute(cartStore);
    if (result.isSuccess) {
      yield CreateOrderSuccess();
    } else {
      yield CreateOrderFailed();
    }
  }
}
