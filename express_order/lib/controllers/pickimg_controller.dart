import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickimgController extends GetxController {
  Rx<File?> image = Rx(null);
  final picker = ImagePicker();
  final List listimage = [];

  onOpenGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image!.value = File(pickedFile!.path);
    return image;
  }
}
