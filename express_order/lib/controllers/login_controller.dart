import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  String email = "";
  String password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  userLoogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.toNamed("/usermain");
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        Get.snackbar(
            "email incorrect", "aucun utilisateur associé à cet adresse email");
      } else if (error.code == 'wrong-password') {
        Get.snackbar("mot de passe incorrect", "Mot de passe incorrect");
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir une adresse mail';
    } else if (!value.contains('@')) {
      return 'Veuillez saisir une adresse valide';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre mot de passe';
    }
    return null;
  }

  validnLogin() {
    if (formKey.currentState!.validate()) {
      email = emailController.text;
      password = passwordController.text;
      userLoogin();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
