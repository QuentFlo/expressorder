import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotpassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String email = "";
  final emailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar("Réinitialisation", "Un mail de réinitialisation vous a été envoyé !");
      Get.toNamed("/");
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        Get.snackbar("Utilisateur", "Aucun utilisateur associé à cet adresse email");
      }
    }
  }

    validnReset() {
    if (formKey.currentState!.validate()) {
      email = emailController.text;
      resetPassword();
    }
  }
}
