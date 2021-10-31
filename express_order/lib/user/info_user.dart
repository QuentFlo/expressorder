import 'package:express_order/pages/map.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:express_order/pages/map.dart';


class MyInfoPage extends StatefulWidget {
  final DocumentSnapshot ds;
   const MyInfoPage({required this.ds, Key? key}) : super(key: key);
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  String? productImage;
  String? id;
  String? name;
  String? recipe;
  TextEditingController? nameInputController;
  TextEditingController? recipeInputController;  
  TextEditingController? longitudeInputController;
  TextEditingController? latitudeController;

  Location location = Location();
    LocationData? locationData;
  LocationData? _Location;
  LocationData? _location2;
  
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


  Future getPost() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("colitems").get();

    return qn.docs;
  }

  locationhard() async {

      locationData = await getLocation();
      setState(() {
        _Location = locationData;
      });
    print("hum?????");
    print(_Location);
  }

   @override
  void initState() {
    super.initState();

    recipeInputController =
        TextEditingController(text: widget.ds["item"]);
    nameInputController =
        TextEditingController(text: widget.ds["name"]);
    longitudeInputController =
        TextEditingController(text: widget.ds["longitude"]);
    latitudeController =
        TextEditingController(text: widget.ds["latitude"]);
    productImage = widget.ds["image"];

    locationhard();
  
  }



  @override
  Widget build(BuildContext context) {
    getPost();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)),
                      padding: const EdgeInsets.all(5.0),
                      child: productImage == ''
                          ? const Text('Modifier')
                          : Image.network(productImage !+ '?alt=media'),
                    ),                    
                  ],
                ),
                // const IniciarIcon(),
                ListTile(
                  leading: const Icon(Icons.article, color: Colors.black),
                  title: Text(
                    nameInputController!.text,),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.black),
                  title: Text(
                    recipeInputController!.text,
                    maxLines: 10,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                //print(locationData)
                _Location != null ? Text(_Location!.latitude.toString() + "   " + _Location!.longitude.toString()) : const Text("Localisation non disponible"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => MyMap (location: _Location, longitude: double.parse(widget.ds["longitude"]), latitude: double.parse(widget.ds["latitude"]),))
                    );
                  }, 
                  child: const Text('ouvrir carte'),
                  )
                //Text(_Location!.latitude.toString() + "   " + _Location!.longitude.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class IniciarIcon extends StatelessWidget {
  const IniciarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: const <Widget>[
          IconoMenu(
            icon: Icons.call,
            label: "Call",
          ),
          IconoMenu(
            icon: Icons.message,
            label: "Message",
          ),
          IconoMenu(
            icon: Icons.place,
            label: "Place",
          ),
        ],
      ),
      
    );
  }
}

class IconoMenu extends StatelessWidget {
  const IconoMenu({required this.icon, required this.label, Key? key}) : super(key: key);
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 50.0,
            color: Colors.blue,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12.0, color: Colors.blue),
          )
        ],
      ),
    );
  }
}