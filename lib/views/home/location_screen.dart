// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LocationScreen(),
//     );
//   }
// }

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   String locationMessage = "Press the button to get location";
//   String address = "";

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() {
//         locationMessage = "Location services are disabled.";
//       });
//       return;
//     }

//     // Request permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           locationMessage = "Location permissions are denied";
//         });
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() {
//         locationMessage =
//             "Location permissions are permanently denied. Enable them in settings.";
//       });
//       return;
//     }

//     // Get GPS coordinates
//     Position position = await Geolocator.getCurrentPosition(
//       locationSettings: LocationSettings(
//         accuracy: LocationAccuracy.best
//       ),
//     );

//     setState(() {
//       locationMessage =
//           "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
//     });

//     // Convert coordinates into human-readable address
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);

//     Placemark place = placemarks.first;

//     setState(() {
//       address =
//           "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("User Location with Address")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(locationMessage,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 16)),
//             const SizedBox(height: 10),
//             Text(address,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                     fontSize: 16, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getCurrentLocation,
//               child: const Text("Get Location & Address"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// //new
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   String locationMessage = "Press the button to get location";
//   String address = "";

//   Future<void> _getCurrentLocation() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         setState(() {
//           locationMessage = "Location services are disabled.";
//         });
//         return;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           setState(() {
//             locationMessage = "Location permissions are denied.";
//           });
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         setState(() {
//           locationMessage =
//               "Location permissions are permanently denied. Enable them in settings.";
//         });
//         return;
//       }

//       // Get user location
//       Position position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );

//       setState(() {
//         locationMessage =
//             "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
//       });

//       // Reverse geocoding
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks.first;

//         String fullAddress = [
//           place.name,
//           place.street,
//           place.subLocality,
//           place.locality,
//           place.subAdministrativeArea,
//           place.administrativeArea,
//           place.postalCode,
//           place.country,
          
//         ].where((e) => e != null && e.isNotEmpty).join(", ");

//         setState(() {
//           address = fullAddress;
//         });
//       } else {
//         setState(() {
//           address = "Address not found.";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         locationMessage = "Error getting location: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("User Location with Address")),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(locationMessage,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               Text(address,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _getCurrentLocation,
//                 child: const Text("Get Location & Address"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


//with getx

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/location_controller.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(title: const Text("User Location with Address")),
      body: Center(
        child: Obx(() => SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locationController.locationMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    locationController.address.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => locationController.getCurrentLocation(),
                    child: const Text("Refresh Location"),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
