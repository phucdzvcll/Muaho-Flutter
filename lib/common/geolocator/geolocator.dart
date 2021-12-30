import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muaho/common/common.dart';

class AppGeoLocator {
  Future<LocationPermissionApp> _checkPermission() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    return _mapPermission(locationPermission);
  }

  LocationPermissionApp _mapPermission(LocationPermission locationPermission) {
    switch (locationPermission) {
      case LocationPermission.denied:
        return LocationPermissionApp.denied;
      case LocationPermission.deniedForever:
        return LocationPermissionApp.deniedForever;
      case LocationPermission.whileInUse:
        return LocationPermissionApp.whileInUse;
      case LocationPermission.always:
        return LocationPermissionApp.always;
    }
  }

  Future<LocationPermissionApp> requestPermission() async {
    LocationPermissionApp checkPermission = await _checkPermission();
    if (checkPermission == LocationPermissionApp.denied) {
      return _mapPermission(await Geolocator.requestPermission());
    } else {
      return checkPermission;
    }
  }

  Future<bool> isLocationEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<AppPosition?> getCurrentPosition() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        timeLimit: Duration(seconds: 15),
      );
      return AppPosition(
          longitude: currentPosition.longitude,
          latitude: currentPosition.latitude,
          timestamp: currentPosition.timestamp,
          accuracy: currentPosition.accuracy,
          altitude: currentPosition.altitude,
          heading: currentPosition.heading,
          speed: currentPosition.speed,
          speedAccuracy: currentPosition.speedAccuracy);
    } catch (_) {
      return null;
    }
  }

  Future<List<Place>?> getPlaces(double lat, double lng) async {
    try {
      List<Place> places =
          await placemarkFromCoordinates(lat, lng).then((value) => value
              .map(
                (e) => Place(
                  name: e.name.defaultEmpty(),
                  street: e.street.defaultEmpty(),
                  isoCountryCode: e.isoCountryCode.defaultEmpty(),
                  country: e.country.defaultEmpty(),
                  postalCode: e.postalCode.defaultEmpty(),
                  administrativeArea: e.administrativeArea.defaultEmpty(),
                  subAdministrativeArea: e.subAdministrativeArea.defaultEmpty(),
                  locality: e.locality.defaultEmpty(),
                  subLocality: e.subLocality.defaultEmpty(),
                  thoroughfare: e.thoroughfare.defaultEmpty(),
                  subThoroughfare: e.subThoroughfare.defaultEmpty(),
                ),
              )
              .toList());
      return places;
    } catch (_) {
      return null;
    }
  }
}

class Place {
  const Place({
    required this.name,
    required this.street,
    required this.isoCountryCode,
    required this.country,
    required this.postalCode,
    required this.administrativeArea,
    required this.subAdministrativeArea,
    required this.locality,
    required this.subLocality,
    required this.thoroughfare,
    required this.subThoroughfare,
  });

  final String name;
  final String street;
  final String isoCountryCode;
  final String country;
  final String postalCode;
  final String administrativeArea;
  final String subAdministrativeArea;
  final String locality;
  final String subLocality;
  final String thoroughfare;
  final String subThoroughfare;
}

class AppPosition {
  final double latitude;
  final double longitude;
  final DateTime? timestamp;
  final double altitude;
  final double accuracy;
  final double heading;
  final int? floor;
  final double speed;
  final double speedAccuracy;
  final bool isMocked;

  const AppPosition({
    required this.longitude,
    required this.latitude,
    required this.timestamp,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.speedAccuracy,
    this.floor,
    this.isMocked = false,
  });
}

enum LocationPermissionApp { denied, deniedForever, whileInUse, always }
