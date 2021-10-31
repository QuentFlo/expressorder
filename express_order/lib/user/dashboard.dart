import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
  final List listtest = [];
  final List listimage = [];
  late File? image;

}

class _State extends State<Dashboard> {

  //File? image;
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
    
    Future onOpenGallery() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);


        widget.image = File(pickedFile!.path);
        listimage.add(widget.image);
 
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
                    //controller.onOpenGallery();
                    onOpenGallery();
                    
                  },
                  elevation: 5,
                  child: const Text("Choose photo"))
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                      // controller.onOpenGallery();
                      ok = onValue;
                      widget.listtest.add(ok);
                      //ref.child(widget.ok).set()

                      ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
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
                      
                      listtest.add(ok);
                      ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
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
            // if (Widget._locationData != null) {
            //   const Text(widget._locationData.toString());
            // };
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
