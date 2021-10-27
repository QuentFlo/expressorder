import 'package:express_order/controllers/forgotpass_controller.dart';
import 'package:express_order/controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotpassController());
    final calloginfunc = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('réinitialiser mot de passe'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset('images/password.png'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: const Text(
              'un lien de réinitialisation va vous être envoyé par email !',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
              child: Form(
            key: controller.formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 15.0,
                          )),
                      controller: controller.emailController,
                      validator: calloginfunc.validateEmail,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => controller.validnReset(),
                          child: const Text(
                            'Envoyer ',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed("/");
                          },
                          child: const Text(
                            'Connexion',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Vous n'avez pas de compte ?"),
                      TextButton(
                          onPressed: () {
                            Get.toNamed("/sigup");
                          },
                          child: const Text('Inscription')),
                    ],
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}