import 'package:get/get.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  final Location location = Location();
  late LocationData _locationData;
  
  getLocation() async {

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    location.enableBackgroundMode(enable: true);
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    return (_locationData);
//     location.onLocationChanged.listen((LocationData currentLocation) {
//   // Use current location
// });

  }
}
