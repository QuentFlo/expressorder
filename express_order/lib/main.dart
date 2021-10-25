import 'package:express_order/pages/forgot_pass.dart';
import 'package:express_order/pages/login.dart';
import 'package:express_order/pages/signup.dart';
import 'package:express_order/pages/user_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp>_initialization = Firebase.initializeApp();

   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _initialization,
    builder: (context, snapshot){
      if(snapshot.hasError){
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'ExpressOrder',
          theme: ThemeData(
              primarySwatch: Colors.blue
      ),
          home:const LoginPage(),
          getPages: [
            GetPage(name: "/", page: () => const LoginPage()),
            GetPage(name: "/usermain", page: () => const UserMain()),
            GetPage(name: "/forgotpass", page: () => const ForgotPass()),
            GetPage(name: "/signup", page: () => const Signup()),
          ],
      );
    });
  }
}
