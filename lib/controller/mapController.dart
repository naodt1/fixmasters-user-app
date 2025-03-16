// import 'package:get/get.dart';
// import 'package:mapbox_gl_modified/mapbox_gl_modified.dart';
// import '../services/map_services.dart';
//
//
// class MapController extends GetxController {
//   var latitude = 0.0.obs;
//   var longitude = 0.0.obs;
//   var isLocationLoading = true.obs;
//
//   MapService mapService = MapService();
//
//   @override
//   void onInit() {
//     super.onInit();
//     updateLocation();
//   }
//
//   void updateLocation() async {
//     isLocationLoading.value = true;
//     LatLng? location = await mapService.getCurrentUserLocation();
//     if (location != null) {
//       latitude.value = location.latitude;
//       longitude.value = location.longitude;
//     }
//     isLocationLoading.value = false;
//   }
// }
