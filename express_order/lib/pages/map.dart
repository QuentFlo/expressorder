import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MyMap extends StatefulWidget {

  LocationData? location;

  MyMap({required this.location  , Key? key }) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  // print(location);
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(widget.location!.latitude!, widget.location!.longitude!),
        zoom: 18.0,
        minZoom: 16.0,
        maxZoom: 18.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(widget.location!.latitude!, widget.location!.longitude!),
            builder: (ctx) =>
              const FlutterLogo(),
          ),
          ]
        )
      ],
    );
  }
}