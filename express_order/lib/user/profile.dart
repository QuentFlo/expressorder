import 'package:express_order/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async{
    if(user != null && !user!.emailVerified){
      await user!.sendEmailVerification();
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Un mail de vérification a été envoyé',
        style: TextStyle(fontSize: 18.0, color: Colors.amber),),
      ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
              child: Image.asset('images/profil.png'),),
          const SizedBox(height: 50.0,),
          Column(
            children: const [
/*              Text(
                  'ID utilisateur:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                uid,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300,),
              )*/
            ],
          ),
          const SizedBox(height: 50.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Email: $email',
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100,),
              ),

              /*user!.emailVerified ? Text('Vérifié',
              style: TextStyle(fontSize: 22.0, color: Colors.lightBlue),
              ) :

              TextButton(onPressed: () => {
                verifyEmail()
              },
                  child: Text(' Verifier Email',
                  style: TextStyle(fontSize: 22.0, color: Colors.lightBlue),),
              ),*/
            ],
          ),
          const SizedBox(height: 50.0,),
          Column(
            children: [
              const Text('Crée le : ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                creationTime.toString(),
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300,),
              )
            ],
          ),
          const SizedBox(height: 50.0,),
          ElevatedButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage(),), (route) => false);
          },
              child: const Text(
                  'Deconnexion',
              style: TextStyle(fontSize: 18.0),
              ),
          ),
        ],
      ),
    );
  }
}