// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   String latitude = "";
//   String longitude = "";
//   String city = "";
//   String state = "";
//   String postalCode = "";
//   String country = "";
//   String address = "";

//   bool loading = false;

//   Future<void> _getLocationDetails() async {
//     setState(() => loading = true);

//     try {
//       // Step 1: Check permissions
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         setState(() {
//           address = "Location services are disabled.";
//           loading = false;
//         });
//         return;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           setState(() {
//             address = "Location permissions are denied.";
//             loading = false;
//           });
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         setState(() {
//           address =
//               "Location permissions are permanently denied, cannot request.";
//           loading = false;
//         });
//         return;
//       }

//       // Step 2: Get current location
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // Step 3: Convert to address
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);

//       Placemark place = placemarks[0];

//       setState(() {
//         latitude = position.latitude.toString();
//         longitude = position.longitude.toString();
//         city = place.locality ?? "";
//         state = place.administrativeArea ?? "";
//         postalCode = place.postalCode ?? "";
//         country = place.country ?? "";
//         address =
//             "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
//       });
//     } catch (e) {
//       setState(() {
//         address = "Error: $e";
//       });
//     }

//     setState(() => loading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Current Location")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ElevatedButton(
//               onPressed: _getLocationDetails,
//               child: const Text("Get Current Location"),
//             ),
//             const SizedBox(height: 20),

//             if (loading) const Center(child: CircularProgressIndicator()),

//             if (!loading && latitude.isNotEmpty) ...[
//               Text("Latitude: $latitude"),
//               Text("Longitude: $longitude"),
//               Text("City: $city"),
//               Text("State: $state"),
//               Text("Postal Code: $postalCode"),
//               Text("Country: $country"),
//               const SizedBox(height: 10),
//               Text("Full Address: $address"),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
