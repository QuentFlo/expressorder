import 'package:express_order/pages/login.dart';
import 'package:express_order/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.amber,
        content: Text('Un mail de réinitialisation vous a été envoyé !',
        style: TextStyle(fontSize: 18.0),
        ),
      ),
      );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),),);
    } on FirebaseAuthException catch(error){
      if(error.code == 'user-not-found'){
        print('Aucun utilisateur associé à cet adresse email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber,
          content: Text('Aucun utilisateur associé à cet adresse email',
            style: TextStyle(fontSize: 18.0, color: Colors.amber),
          ),
        ),
        );
      }
    }
}

@override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('réinitialiser mot de passe'),
      ),
      body: Column(
        children: [
         Padding(
             padding: const EdgeInsets.all(20.0),
         child: Image.asset('images/password.png'),
         ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text('un lien de réinitialisation va vous être envoyé par email !',
            style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black26,fontSize: 15.0,
                            )
                          ),
                          controller: emailController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Veuillez saisir une adresse email';
                            }
                            else if(!value.contains('@')){
                              return 'Veuillez saisir une adresse email valide';
                            }
                            return null;
                          },
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
                                });
                                resetPassword();
                              }
                            },
                                child: Text('Envoyer ',
                                style: TextStyle(fontSize: 18.0),),
                            ),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage(), ),);
                            },
                                child: Text('Connexion',
                                style: TextStyle(fontSize: 13.0),
                                ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Vous n'avez pas de compte ?"),
                            TextButton(onPressed: (){
                              Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b) => Signup(),
                              transitionDuration: Duration(seconds: 0),), (route) => false);
                            },
                                child: Text('Inscription')
                            ),
                          ],
                        ),
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
