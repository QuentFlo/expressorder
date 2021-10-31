import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; //formateo hora

String? filename;
File? image;

class MyUpdatePage extends StatefulWidget {
  final DocumentSnapshot ds;
  const MyUpdatePage({required this.ds, Key? key}) : super(key: key);
  @override
  _MyUpdatePageState createState() => _MyUpdatePageState();
}

class _MyUpdatePageState extends State<MyUpdatePage> {
  late String productImage;
  late TextEditingController recipeInputController;
  late TextEditingController nameInputController;
  late TextEditingController imageInputController;

  String? id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? recipe;

  pickerCam() async {
    File? pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.camera)) as File?;
    if (pickedFile != null) {
      image = pickedFile;
      setState(() {});
    }
  }

  pickerGallery() async {
    final pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
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

  @override
  void initState() {
    super.initState();
    recipeInputController = TextEditingController(text: widget.ds["item"]);
    nameInputController = TextEditingController(text: widget.ds["name"]);
    productImage = widget.ds["image"]; //nuevo
  }

  /*
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('colrecipes')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      // print(e);
    });
  }
  */

  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("colrecipe").get();
    // print();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    getPosts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier'),
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
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: image == null
                          ? const Text('Add')
                          : Image.file(image!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.2),
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        padding: const EdgeInsets.all(5.0),
                        child: productImage == ''
                            ? const Text('Modifier')
                            : Image.network(productImage + '?alt=media'),
                      ),
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
                  controller: nameInputController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nom article',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir un titre';
                    }
                  },
                  onSaved: (value) => name = value,
                ),
                TextFormField(
                  controller: recipeInputController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir une description';
                    }
                  },
                  onSaved: (value) => recipe = value,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Modifier'),
                onPressed: () {
                  DateTime now = DateTime.now();
                  String nuevoformato =
                      DateFormat('kk:mm:ss:MMMMd').format(now);
                  var fullImageName = 'nomfoto-$nuevoformato' '.jpg';
                  var fullImageName2 = 'nomfoto-$nuevoformato' '.jpg';

                  final Reference ref =
                      FirebaseStorage.instance.ref().child(fullImageName);
                  ref.putFile(image!);

                  var part1 =
                      'https://firebasestorage.googleapis.com/v0/b/expressorder-afeda.appspot.com/o/';

                  var fullPathImage = part1 + fullImageName2;

                  FirebaseFirestore.instance
                      .collection('colitems')
                      .doc(widget.ds.id)
                      .update({
                    'name': nameInputController.text,
                    'recipe': recipeInputController.text,
                    'image': fullPathImage
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
