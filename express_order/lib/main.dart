import 'package:express_order/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp>_initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _initialization,
    builder: (context, snapshot){
      if(snapshot.hasError){
        print("une erreur s'est produite");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }
      return MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Email & Mot de passe',
          theme: ThemeData(
              primarySwatch: Colors.blue
      ),
          home:LoginPage()
      );
    });
  }
}
