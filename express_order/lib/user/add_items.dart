import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math';


File? image;
String? filename;

class CommonThings {
  static Size? size;
}

class MyAddPage extends StatefulWidget {
  const MyAddPage({Key? key}) : super(key: key);

  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  TextEditingController? itemsInputController;
  TextEditingController? nameInputController;
  TextEditingController? imageInputController;

  String? id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String? name;
  final rng = Random();
  String? item;
  String ok = "";

  pickerCam() async {
    File? pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.camera)) as File?;
    if (pickedFile != null) {
      image = pickedFile;
      setState(() {});
    }
  }

  pickerGallery() async {
    final pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  void createData() async {
    DateTime now = DateTime.now();
    String nuevoformato = DateFormat('kk:mm:ss:MMMMd').format(now);
    var fullImageName = 'imageitem';
    var fullImageName2 = 'nomfoto-$nuevoformato' '.jpg';
    ok = rng.nextInt(100).toString();

    final Reference ref = FirebaseStorage.instance.ref().child(fullImageName + ok);
    final UploadTask task = ref.putFile(image!);

    var part1 =
        'https://firebasestorage.googleapis.com/v0/b/expressorder-afeda.appspot.com/o/imageitem';

    var fullPathImage = part1 + ok;


    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      DocumentReference ref = await db
          .collection('colitems')
          .add({'name': '$name', 'item': '$item', 'image': fullPathImage});
      setState(() => id = ref.id);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: image == null
                          ? const Text('inserez une image')
                          : Image.file(image!),
                    ),
                    const Divider(),
                    IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: pickerCam),
                    const Divider(),
                    IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: pickerGallery),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Titre',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => name = value,
                ),
                TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'articles',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some recipe';
                    }
                  },
                  onSaved: (value) => item = value,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: createData,
                child:
                    const Text('Create', style: TextStyle(color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
