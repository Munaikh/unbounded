import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocationService {
  final _logger = Logger();

  Future<Position?> getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      try {
        final Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
        );
        return position;
      } catch (e) {
        _logger.e('Error getting location: $e');
        return null;
      }
    } else {
      _logger.e('Location permission not granted.');
      return null;
    }
  }
}