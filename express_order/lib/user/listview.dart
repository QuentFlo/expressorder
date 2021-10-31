import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:express_order/user/add_items.dart';
import 'package:express_order/user/update_items.dart';
import 'package:express_order/user/info_user.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boutique',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyListPage(),
    );
  }
}

class CommonThings {
  static Size? size;
}

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {

  TextEditingController? phoneInputController;
  TextEditingController? nameInputController;
  String? id;
  final db = FirebaseFirestore.instance;
  String? name;
  String? phone;

  //create tha funtion navigateToDetail
  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyUpdatePage(
                  ds: ds,
                )));
  }

  //create tha funtion navigateToDetail
  navigateToInfo(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyInfoPage(
                  ds: ds,
                )));
  }


  void deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').doc(doc.id).delete();
    setState(() => id = null);
  }

  @override
  Widget build(BuildContext context) {

    CommonThings.size = MediaQuery.of(context).size;
    //print('Width of the screen: ${CommonThings.size.width}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("colitems").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("Chargement....");
          }
          int length = snapshot.data!.docs.length;
          //print("from the streamBuilder: "+ snapshot.data.documents[]);
          // print(length.toString() + " doc length");
          return ListView.builder(
            itemCount: length,
            itemBuilder: (_, int index) {
              final DocumentSnapshot doc = snapshot.data!.docs[index];
              return Container(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  child: Row(
                    children: <Widget>[
                      
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(
                          '${doc["image"]}' '?alt=media',
                        ),
                        width: 100,
                        height: 100,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            doc["name"],
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 21.0,
                            ),
                          ),
                          subtitle: Text(
                            doc["phone"],
                            style: const TextStyle(
                                color: Colors.redAccent, fontSize: 21.0),
                          ),
                          onTap: () => navigateToDetail(doc),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => deleteData(doc), //funciona
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.blueAccent,
                        ),
                         onPressed: () => navigateToInfo(doc),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => const MyAddPage());
          Navigator.push(context, route);
        },
      ),
    );
  }
}