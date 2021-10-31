import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';

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
  final rng = Random();
  String? item;
  String ok = "";

  pickerCam() async {
    final pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.camera));
    if (pickedFile != null) {
      image = File(pickedFile.path);
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
    ref.putFile(image!);

    var part1 =
        'https://firebasestorage.googleapis.com/v0/b/expressorder-afeda.appspot.com/o/imageitem';

    var fullPathImage = part1 + ok;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      DocumentReference ref = await db
          .collection('colitems')
          .add({'name': '$name', 'item': '$item', 'image': fullPathImage});
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
