import 'package:express_order/controllers/changepass_controller.dart';
import 'package:express_order/controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePass extends StatelessWidget {
  const ChangePass({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangepassController());
    final calloginfunc = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: ListView(
              children: [
                const SizedBox(height: 100,),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                child: Image.asset('images/settings.png'),),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Nouveau mot de passe:',
                      hintText: 'Entrer votre nouveau mot de passe',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black26, fontSize: 15.0),
                    ),
                    controller: controller.newPasswordController,
                    validator: calloginfunc.validatePassword,
                  ),
                ),
                ElevatedButton(onPressed: () => controller.validnChange(),
                    child: const Text('Changer mot de passe',
                    style: TextStyle(fontSize: 18.0),
                    ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}