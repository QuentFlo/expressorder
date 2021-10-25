import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
  late File image;
  String ok = " ";
  final List listtest = [];
  final List listimage = [];

}

class _State extends State<Dashboard> {

 late File image;
  late String ok = " ";
  final List listtest = [];
  final List listimage = [];

  Future<dynamic> createAlertDialog2(BuildContext context) {
    TextEditingController customContrller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Article à Acheter"),
            content: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(1),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                  ),
                  controller: customContrller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Prix Max',
                  ),
                ),
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(customContrller.text.toString());
                  },
                  elevation: 5,
                  child: const Text("Search")),
              MaterialButton(
                  onPressed: () {}, elevation: 5, child: const Text("Open Map"))
            ]),
          );
        });
  }

  Future<dynamic> createAlertDialog(BuildContext context) {
    TextEditingController customContrller = TextEditingController();
    final picker = ImagePicker();

    Future OnOpenGallery() async {
      final PickedFile = await picker.getImage(source: ImageSource.gallery);

      if (PickedFile != null) {
        image = File(PickedFile.path);
        listimage.add(image);
      } else
        print('No image selected.');
    }


    //widget.listimage.add(widget.image);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Article à vendre"),
            content: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(1),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                  ),
                  controller: customContrller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Prix',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(customContrller.text.toString());
                  },
                  elevation: 5,
                  child: const Text("Submit")),
              MaterialButton(
                  onPressed: () {
                    OnOpenGallery();

                  },
                  elevation: 5,
                  child: const Text("Choose photo"))
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String kok;

    return Scaffold(
      appBar: AppBar(title: const Text("Boutique")),
      body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              TextButton(
                  child: const Text("Vendre"),
                  onPressed: () {
                    createAlertDialog(context).then((onValue) {
                      SnackBar mySnackBar = SnackBar(
                        content: Text("$onValue en vente"),
                      );
                      widget.ok = onValue;
                      widget.listtest.add(widget.ok);
                      //ref.child(widget.ok).set()

                      Scaffold.of(context).showSnackBar(mySnackBar);
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  )),

              TextButton(
                  child: const Text("Acheter"),
                  onPressed: () {
                    createAlertDialog2(context).then((onValue) {
                      SnackBar mySnackBar = SnackBar(
                        content: Text("$onValue trouvé"),
                      );
                      
                      ok = onValue;
                      
                      listtest.add(
                        ok);
                      Scaffold.of(context).showSnackBar(mySnackBar);
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  )),
              const Text("Article mis en vente"),
              //Text(
              //ok),
              //Image.file(widget.image),

              // ListView.builder(
              //   itemCount: widget.listtest.length,
              //   itemBuilder: (context, i) {
              //     return ListTile(
              //         leading: Icon(Icons.place),
              //         title: widget.listtest[i].city);
              //   },
              // )
            ]),

            ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              itemCount: listtest.length,
              itemBuilder: (context, i) {
                return Card(
                    child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(listtest[i]),
                )
                    //Image.file(widget.listimage[i])

                    );
                //child: Image.file(widget.image),
              },
              separatorBuilder: (context, i) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.file(listimage[i])
                  )
                );
              },
            )
          ]),
    );
  }
}
