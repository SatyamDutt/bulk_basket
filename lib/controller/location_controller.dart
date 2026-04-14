import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  RxString locationMessage = "Fetching location...".obs;
  RxString address = "".obs;
  RxString district = "".obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationMessage.value = "Location services are disabled.";
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationMessage.value = "Location permissions are denied.";
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationMessage.value =
            "Location permissions are permanently denied. Enable them in settings.";
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      locationMessage.value =
          "Lat: ${position.latitude}, Lng: ${position.longitude}";

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        district.value = place.locality ?? 'Not found';
        String fullAddress = [
          place.name,
          place.street,
          place.subLocality,
          place.locality,
          place.subAdministrativeArea,
          place.administrativeArea,
          place.postalCode,
          place.country
        ].where((e) => e != null && e.isNotEmpty).join(", ");

        address.value = fullAddress;
      } else {
        address.value = "Address not found.";
      }
    } catch (e) {
      locationMessage.value = "Error getting location: $e";
    }
  }
}
