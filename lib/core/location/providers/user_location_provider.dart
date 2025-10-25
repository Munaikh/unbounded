import 'package:apparence_kit/core/location/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_provider.g.dart';

@Riverpod(keepAlive: true)
class UserLocation extends _$UserLocation {
  @override
  Position? build() {
    return null;
  }

  Future<Position?> getUserLocation() async {
    final locationService = LocationService();
    final position = await locationService.getUserLocation();
    state = position;
    return position;
  }

  double getDistanceTo(double latitude, double longitude) {
    if (state == null) {
      return 0.0;
    }
    return Geolocator.distanceBetween(
      state!.latitude,
      state!.longitude,
      latitude,
      longitude,
    );
  }
}
