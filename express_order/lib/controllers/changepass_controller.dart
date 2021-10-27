import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangepassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String newPassword = " ";
  final newPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Get.toNamed("/");
      Get.snackbar("Mot de passe", "Votre mot de passe a été changé. Veuillez vous reconnecter !");
    } catch (error) {
      debugPrint("error");
    }
  }

  validnChange() {
    if (formKey.currentState!.validate()) {
      newPassword = newPasswordController.text;
      changePassword();
    }
  }
}
