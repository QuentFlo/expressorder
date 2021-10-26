import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupController extends GetxController {
  String email = "";
  String password = "";
  String confirmPassword = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  registration() async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        debugPrint(userCredential.toString());
        Get.snackbar("Inscription", "Inscription réussie");
        Get.toNamed("/");
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          Get.snackbar("Mot de passe", "Mot de passe trop faible");
        } else if (error.code == 'email-already-in-use') {
          Get.snackbar("Adresse email", "Adresse email déjà utilisée");
        }
      }
    } else {
      Get.snackbar("Mot de passe", "Les mots de passe ne correspondent pas");
    }
  }

  validnRegister() {
    if (formKey.currentState!.validate()) {
      email = emailController.text;
      password = passwordController.text;
      confirmPassword = confirmController.text;
      registration();
    }
  }

  String? confirmPass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirmez votre mot de passe';
    }
    return null;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}
