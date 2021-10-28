import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PickimgController extends GetxController {
  Rx<File?> image = Rx(null);
  final picker = ImagePicker();
  final List listimage = [];
  final _storage = FirebaseStorage.instance;
  String? imageUrl;

  onOpenGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image.value = File(pickedFile!.path);
    return image;
  }

  uploadImage(name) async {
  var snapshot = _storage.ref().child(name).putFile(image.value!);

  var downloadURL = await snapshot;
  return downloadURL;
  }

}