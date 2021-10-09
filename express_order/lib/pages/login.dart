import 'package:express_order/pages/forgot_pass.dart';
import 'package:express_order/pages/signup.dart';
import 'package:express_order/pages/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLoogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserMain()));
    }on FirebaseAuthException catch(error){
      if(error.code == 'user-not-found'){
        print('aucun utilisateur associé à cet adresse email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor : Colors.blueGrey,
          content : Text('aucun utilisateur associé à cet adresse email',
          style: TextStyle(fontSize: 18.0, color: Colors.amber),)
        ),
        );
      }
      else if (error.code == 'wrong-password'){
        print('Mot de passe incorrect');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor : Colors.blueGrey,
            content : Text('Mot de passe incorrect',
              style: TextStyle(fontSize: 18.0, color: Colors.amber),)
        ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              Padding(padding: const EdgeInsets.all(0.0),
          child: Image.asset('images/login.png'),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,
                    fontSize: 15),
                  ),
                  controller: emailController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Veuillez saisir une adresse mail';
                    }
                    else if(!value.contains('@')){
                      return 'Veuillez saisir une adresse valide';
                    }
                    return null;
                  }
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,
                        fontSize: 15),
                  ),
                    controller: passwordController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Veuillez saisir votre mot de passe';
                      }
                      return null;
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          email = emailController.text;
                          password = passwordController.text;
                        });
                        userLoogin();
                      }
                    },
                        child: Text(
                          'Connexion',
                          style: TextStyle(fontSize: 18.0),
                        ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPass(),),);
                    } , child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(fontSize: 12.0),
                    ))
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Pas de compte ?'),
                    TextButton(onPressed: (){
                      Navigator.pushAndRemoveUntil(context,PageRouteBuilder(pageBuilder: (context,a,b) => Signup(), transitionDuration: Duration(seconds: 0)), (route) => false);
                    },
                        child: Text('Inscription'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
