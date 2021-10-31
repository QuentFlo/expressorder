import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:express_order/controllers/map_controller.dart';
import 'package:location/location.dart';


class AddController extends GetxController {
  File? image;
  String? filename;

  TextEditingController? itemsInputController;
  TextEditingController? nameInputController;
  TextEditingController? imageInputController;

  String? id;
  final db = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  String? name;
  String? Latitude;
  String? Longitude;
  LocationData? locationData;

  final rng = Random();
  String? item;
  String ok = "";
  final contrllermap = Get.put(MapController());

  pickerCam() async {
    File? pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.camera)) as File?;
    if (pickedFile != null) {
      image = pickedFile;
    }
  }

  pickerGallery() async {
    final pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  void createData() async {
    var fullImageName = 'imageitem';
    ok = rng.nextInt(100).toString();
    
    final Reference ref =
        FirebaseStorage.instance.ref().child(fullImageName + ok);
    final UploadTask task = ref.putFile(image!);

    var part1 =
        'https://firebasestorage.googleapis.com/v0/b/expressorder-afeda.appspot.com/o/imageitem';

    var fullPathImage = part1 + ok;

    locationData = await contrllermap.getLocation();
    Longitude = locationData!.longitude.toString();
    Latitude = locationData!.latitude.toString();
        print("TEEEEEST");
    print(locationData);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      DocumentReference ref = await db
          .collection('colitems')
          .add({'name': '$name', 'item': '$item', 'image': fullPathImage, 'longitude': '$Longitude', 'latitude': '$Latitude'});
      id = ref.id;
      Get.back();
    }
  }

  String? validateTitle(String? value) {
    if (value!.isEmpty) {
      return 'Veuillez saisir un titre';
    }
  }

  String? validateDesc(String? value) {
    if (value!.isEmpty) {
      return 'Veuillez saisir une description';
    }
  }
}
