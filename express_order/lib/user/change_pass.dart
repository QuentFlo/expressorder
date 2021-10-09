import 'package:express_order/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {

  final _formKey = GlobalKey<FormState>();
  var newPassword = " ";
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async{
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),
      ),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Votre mot de passe a été changé. Veuillez vous reconnecter !'),
      ),
      );
    } catch (error){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: ListView(
              children: [
                SizedBox(height: 100,),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                child: Image.asset('images/login.jpg'),),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Nouveau mot de passe:',
                      hintText: 'Entrer votre nouveau mot de passe',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black26, fontSize: 15.0),
                    ),
                    controller: newPasswordController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return ' Veuillez saisir un mot de passe';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(onPressed: () {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      newPassword = newPasswordController.text;
                    });
                    changePassword();
                  }
                },
                    child: Text('Changer mot de passe',
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