import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:express_order/controllers/map_controller.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class MyInfoPage extends StatefulWidget {
  final DocumentSnapshot ds;
  const MyInfoPage({required this.ds});
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

  Location location = Location();
    LocationData? locationData;
  //late LocationData _Location;
  
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
    if (locationData == null) {
      return "no localisation";
    }
    return (locationData);
  }


  Future getPost() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("colitems").get();

    return qn.docs;
  }

   @override
  void initState() {
    super.initState();
    recipeInputController =
        TextEditingController(text: widget.ds["item"]);
    nameInputController =
        TextEditingController(text: widget.ds["name"]);
    productImage = widget.ds["image"];
  
  }



  @override
  Widget build(BuildContext context) {
    getPost();
    //_Location = getLocation();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Page'),
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
                          ? const Text('Edit')
                          : Image.network(productImage !+ '?alt=media'),
                    ),                    
                  ],
                ),
                const IniciarIcon(),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: nameInputController,
                    validator: (value) {
                      if (value!.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: const InputDecoration(
                        hintText: "Name", labelText: "Name"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                ListTile(
                  leading: const Icon(Icons.list, color: Colors.black),
                  title: TextFormField(
                    maxLines: 10,
                    controller: recipeInputController,
                    validator: (value) {
                      if (value!.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: const InputDecoration(
                        hintText: "item", labelText: "item"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                
                locationData != null ? Text(locationData!.latitude.toString() + "   " + locationData!.longitude.toString()) : Text("no localisation")
                
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
  const IconoMenu({required this.icon, required this.label});
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