import 'package:express_order/controllers/login_controller.dart';
import 'package:express_order/controllers/sigup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Signup extends StatelessWidget {
  const Signup({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final signcontroller = Get.put(SignupController());
    final calloginfunc = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
      key: signcontroller.formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
      child: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(30.0),
          child: Image.asset('images/register.png'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              decoration: const InputDecoration(
                labelText: 'Email:',
                labelStyle: TextStyle(fontSize: 20.0),
                border: OutlineInputBorder(),
                errorStyle:
                  TextStyle(color: Colors.black26, fontSize: 15.0),
              ),
              controller: signcontroller.emailController,
              validator: calloginfunc.validateEmail,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe :',
                labelStyle: TextStyle(fontSize: 20.0),
                border: OutlineInputBorder(),
                errorStyle:
                  TextStyle(color: Colors.black26,
                  fontSize: 15),
              ),
              controller: signcontroller.passwordController,
              validator: calloginfunc.validatePassword,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'confirmez votre mot de passe :',
                labelStyle: TextStyle(fontSize: 20.0),
                border: OutlineInputBorder(),
                errorStyle:
                TextStyle(color: Colors.black26,
                    fontSize: 15),
              ),
              controller: signcontroller.confirmController,
              validator: signcontroller.confirmPass,
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => signcontroller.validnRegister(),
                  child: const Text('Inscription',
                  style: TextStyle(fontSize: 18.0),
                  ),
              ),
            ],
          ),
          const SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Vous avez déjà un compte ?'),
              TextButton(onPressed: (){
                Get.toNamed("/");
              },
                  child: const Text('Connexion'),),
            ],
          ),
        ],
      ),
      ),
      ),
    );
  }
}
