import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyQueryPage(),
    );
  }
}

class MyQueryPage extends StatefulWidget {
  const MyQueryPage({Key? key}) : super(key: key);

  @override
  _MyQueryPageState createState() => _MyQueryPageState();
}

class _MyQueryPageState extends State<MyQueryPage> {
  //List<String> names = List.from(document['name']);
  var selectedCurrency, selectedType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DropDown'),
        ),
        body: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.access_alarm),
                    hintText: 'Alguna cosa',
                    labelText: "Comida"),
              ),
              const SizedBox(
                height: 20.0,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection("colitemd").snapshots(),
                  builder: (context, snapshot) {
                    return DropdownButton<dynamic>(
                      items: snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                        return DropdownMenuItem(
                            child: Text(document['name']));
                      }).toList(),
                      onChanged: (currencyValue) {
                        setState(() {
                          selectedCurrency = currencyValue;
                        });
                      },
                      hint: const Text("Join a Team"),
                      value: selectedCurrency,
                    );
                  }),
            ],
          ),
        ));
  }
}