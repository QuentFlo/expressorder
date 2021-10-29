import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class PickimgController extends GetxController {
  Rx<File?> image = Rx(null);
  final picker = ImagePicker();
  final List listimage = [];
  final _storage = FirebaseStorage.instance;
  String imageUrl = "";


Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];

    final data = FirebaseStorage.instance;
    final ListResult result = await data.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
      });
    });


    return files;
  }

 profilpic() async {
    final images = await loadImages();
    imageUrl = images.last["url"];
    return imageUrl;
  }
  final rng = Random();

  onOpenGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image.value = File(pickedFile!.path);
    return image;
  }

  uploadImage() async {

  var snapshot = _storage.ref().child("ProfileImg"+rng.nextInt(100).toString()).putFile(image.value!);

  var downloadURL = await snapshot;
  return downloadURL;
  }

}