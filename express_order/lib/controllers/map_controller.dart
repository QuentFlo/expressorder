import 'package:get/get.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  Location location = Location();
    LocationData? locationData;
  
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

    locationData = await location.getLocation();
    print("cacaaaaaa");
    print(locationData);
    // if (locationData == null) {
    //   return "Localisation non disponible";
    // }
    return (locationData);
  }
}
