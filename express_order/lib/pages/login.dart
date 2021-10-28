import 'package:express_order/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Image.asset('images/login.png'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.black26, fontSize: 15),
                    ),
                    controller: controller.emailController,
                    validator: controller.validateEmail),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.black26, fontSize: 15),
                    ),
                    controller: controller.passwordController,
                    validator: controller.validatePassword),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.validnLogin(),
                      child: const Text(
                        'Connexion',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed("/forgotpass");
                        },
                        child: const Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(fontSize: 12.0),
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Pas de compte ?'),
                  TextButton(
                      onPressed: () {
                        Get.toNamed("/signup");
                      },
                      child: const Text('Inscription'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}