import 'package:express_order/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  registration() async{
    if(password == confirmPassword){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('Inscription réussie',
          style: TextStyle(fontSize: 20.0),
          ),
        ),
        );
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),),);
        
      }on FirebaseAuthException catch (error){
        if(error.code == 'weak-password'){
          print('Mot de passe trop faible');

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Mot de passe trop faible',
              style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
            ),
          ),
          );
        }
        else if(error.code == 'email-already-in-use'){
          print('Adresse email déjà utilisée');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Adresse email déjà utilisée',
              style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
            ),
          ),
          );
        }
    }
    }
    else {
      print('Les mots de passe ne correspondent pas');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Les mots de passe ne correspondent pas',
          style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
        ),
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
      child: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(30.0),
          child: Image.asset('images/login.jpg'),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Email:',
                labelStyle: TextStyle(fontSize: 20.0),
                border: OutlineInputBorder(),
                errorStyle:
                  TextStyle(color: Colors.black26, fontSize: 15.0),
              ),
              controller: emailController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Veuillez entrer une adresse email';
                }
                else if (!value.contains('@')){
                  return 'Veuillez entrer une adresse email valide';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe :',
                labelStyle: TextStyle(fontSize: 20.0),
                border: OutlineInputBorder(),
                errorStyle:
                  TextStyle(color: Colors.black26,
                  fontSize: 15),
              ),
              controller: passwordController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Veuillez entrer votre mot de passe';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'confirmez votre mot de passe :',
                labelStyle: TextStyle(fontSize: 20.0),
                border: OutlineInputBorder(),
                errorStyle:
                TextStyle(color: Colors.black26,
                    fontSize: 15),
              ),
              controller: confirmController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Confirmez votre mot de passe';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 15,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      email = emailController.text;
                      password = passwordController.text;
                      confirmPassword = confirmController.text;
                    });
                    registration();
                  }
                },
                    child: Text('Inscription',
                    style: TextStyle(fontSize: 18.0),
                    ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Vous avez déjà un compte ?'),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => LoginPage(),
                  transitionDuration: Duration(seconds: 0),),);
                },
                    child: Text('Connexion'),),
              ],
            ),
          ),
        ],
      ),
      ),
      ),
    );
  }
}
