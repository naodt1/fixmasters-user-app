// import 'dart:convert';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'package:mapbox_gl_modified/mapbox_gl_modified.dart';
//
// class MapService {
//   static String? getMapboxAccessToken() {
//     return dotenv.env['MAPBOX_PUBLIC_TOKEN'];
//   }
//
//   Future<LatLng?> getCurrentUserLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       return LatLng(position.latitude, position.longitude);
//     } catch (e) {
//       print('Error fetching user location: $e');
//       return null;
//     }
//   }
//
//   Future<void> moveCameraToLocation(MapboxMapController controller, LatLng location, {double zoom = 15.0}) async {
//     try {
//       controller.animateCamera(CameraUpdate.newLatLngZoom(location, zoom));
//     } catch (e) {
//       print('Error moving camera: $e');
//     }
//   }
//
//   Future<void> addMarker(MapboxMapController controller, LatLng location, String markerId) async {
//     try {
//       controller.addSymbol(SymbolOptions(
//         geometry: location,
//         iconImage: 'marker-15',
//         iconSize: 1.5,
//       ));
//     } catch (e) {
//       print('Error adding marker: $e');
//     }
//   }
//
//   Future<String?> getAddressFromCoordinates(double latitude, double longitude) async {
//     final String? accessToken = getMapboxAccessToken();
//     if (accessToken == null) {
//       print('Mapbox access token is missing.');
//       return null;
//     }
//
//     final String apiUrl =
//         'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$accessToken';
//
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         final List<dynamic> features = data['features'];
//         if (features.isNotEmpty) {
//           final Map<String, dynamic> firstFeature = features[0];
//           return firstFeature['place_name'];
//         }
//       } else {
//         print('Failed to fetch address. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching address: $e');
//     }
//
//     return null;
//   }
// }
