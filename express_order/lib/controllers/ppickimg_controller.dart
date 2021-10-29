import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

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