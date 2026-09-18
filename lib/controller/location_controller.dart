import 'dart:developer';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  RxString locationMessage = "Fetching location...".obs;
  RxString address = "".obs;
  RxString district = "".obs;

  // static const double serviceLat =  25.8606397; // your store location
  // static const double serviceLng =  85.7776978; // OFFICE ADDRESS ---  SAMASTIPUR, BIHAR, INDIA

  // static const double serviceLat =  26.270090151691203; // your store locationY  
  // static const double serviceLng =  86.19858863628743; // OFFICE ADDRESS ---  MADHUBANI, BIHAR, INDIA

  static const double serviceLat =  28.6500; // TEST location
  static const double serviceLng =  77.3500; // TEST ADDRESS

  RxBool isServiceAvailable = false.obs;
  RxBool isCheckingLocation = true.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      isCheckingLocation.value = true;
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationMessage.value = "Location services are disabled.";
        isServiceAvailable.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationMessage.value = "Location permissions are denied.";
          isServiceAvailable.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationMessage.value =
            "Location permissions are permanently denied. Enable them in settings.";
            isServiceAvailable.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      //CHECK 5 KM SERVICES
      double distanceInMeters = Geolocator.distanceBetween(
        serviceLat,
        serviceLng,
        position.latitude,
        position.longitude,
      );

      double distanceInKm = distanceInMeters / 1000;

      isServiceAvailable.value = distanceInKm <= 5;
      //end

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
        log(fullAddress,name: "ADDRSS");
      } else {
        isServiceAvailable.value = false;
        address.value = "Address not found.";
      }
    } catch (e) {
      isServiceAvailable.value = false;
      locationMessage.value = "Error getting location: $e";
    } finally {
      isCheckingLocation.value = false;
    }
  }
}
