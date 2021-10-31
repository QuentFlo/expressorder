import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:express_order/user/add_items.dart';
import 'package:express_order/user/info_user.dart';
import 'package:express_order/user/update_items.dart';

class CommonThings {
  static Size? size;
}

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  TextEditingController? itemsInputController;
  TextEditingController? nameInputController;
  TextEditingController? imageInputController;
  String? id;
  final db = FirebaseFirestore.instance;
  String? name;
  String? item;
  dynamic url;

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('colitems').doc(doc.id).delete();
    setState(() => id = null);
  }

  getFirebase() async {
    final ref = FirebaseStorage.instance.ref();
    url = await ref.getDownloadURL();
    return url;
  }

  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyUpdatePage(
                  ds: ds,
                )));
  }

  navigateToInfo(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyInfoPage(
                  ds: ds,
                )));
  }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Boutique'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("colitems").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Chargement...');
            }
            int length = snapshot.data!.docs.length;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.1,
                  childAspectRatio: 0.800,
                ),
                itemCount: length,
                padding: const EdgeInsets.all(2.0),
                itemBuilder: (_, int index) {
                  final DocumentSnapshot doc = snapshot.data!.docs[index];
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Card(
                            child: InkWell(
                          onTap: () => navigateToDetail(doc),
                          child: Image.network(
                            '${doc["image"]}' '?alt=media',
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        )),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              doc["item"],
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 19.0,
                              ),
                            ),
                            subtitle: Text(
                              doc["name"],
                              style: const TextStyle(
                                  color: Colors.redAccent, fontSize: 12.0),
                            ),
                            onTap: () => navigateToDetail(doc),
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
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
                          ],
                        )
                      ],
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Route route =
              MaterialPageRoute(builder: (context) => const MyAddPage());
          Navigator.push(context, route);
        },
      ),
    );
  }
}
