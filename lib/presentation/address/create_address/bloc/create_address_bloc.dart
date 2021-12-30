import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/geolocator/geolocator.dart';

part 'create_address_event.dart';
part 'create_address_state.dart';

class RequestPermission extends CreateAddressEvent {}

class _RequestCurrentLocation extends CreateAddressEvent {}

class CreateAddressBloc extends Bloc<CreateAddressEvent, CreateAddressState> {
  final AddressTemp addressTemp = AddressTemp();
  final AppGeoLocator appGeoLocator;

  CreateAddressBloc({required this.appGeoLocator})
      : super(CreateAddressInitial()) {
    on<RequestPermission>(
      (event, emit) async {
        bool serviceEnabled = await appGeoLocator.isLocationEnable();
        if (!serviceEnabled) {
          emit(LocationDisable());
        } else {
          LocationPermissionApp permission =
              await appGeoLocator.requestPermission();

          if (permission == LocationPermissionApp.denied) {
            emit(LocationPermissionDenied());
          } else if (permission == LocationPermissionApp.deniedForever) {
            emit(LocationPermissionDeniedForever());
          } else {
            this.add(_RequestCurrentLocation());
          }
        }
      },
    );

    on<_RequestCurrentLocation>((event, emit) async {
      AppPosition? position = await appGeoLocator.getCurrentPosition();
      if (position != null) {
        List<Place>? places = await appGeoLocator.getPlaces(
            position.latitude, position.longitude);
        if (places != null && places.isNotEmpty) {
          emit(
            GetCurrentLocationSuccess(
              addressTemp: AddressTemp(
                lng: position.latitude,
                lat: position.longitude,
                address: places.first.street,
              ),
            ),
          );
        } else {
          emit(GetLocationError());
        }
      } else {
        emit(GetLocationError());
      }
    });
  }
}
