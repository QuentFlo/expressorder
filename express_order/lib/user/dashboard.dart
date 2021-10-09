import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _State createState() => _State();
  late File image;
  late String ok = " ";
  late List listtest = [];
  late List listimage = [];
}

class _State extends State<Dashboard> {
  final _formKey = GlobalKey<FormState>();

  Future<dynamic> createAlertDialog2(BuildContext context) {
    TextEditingController customContrller = TextEditingController();
    final picker = ImagePicker();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Article à Acheter"),
            content: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(1),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Titre',
                  ),
                  controller: customContrller,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prix Max',
                  ),
                ),
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(customContrller.text.toString());
                  },
                  elevation: 5,
                  child: Text("Search")),
              MaterialButton(
                  onPressed: () {}, elevation: 5, child: Text("Open Map"))
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
        widget.image = File(PickedFile.path);
        final fileBytes = widget.image.readAsBytesSync();
        final data = await readExifFromBytes(fileBytes, details: false);
        widget.listimage.add(widget.image);
      } else
        print('No image selected.');
    }


    //widget.listimage.add(widget.image);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Article à vendre"),
            content: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(1),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Titre',
                  ),
                  controller: customContrller,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prix',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(customContrller.text.toString());
                  },
                  elevation: 5,
                  child: Text("Submit")),
              MaterialButton(
                  onPressed: () {
                    OnOpenGallery();

                  },
                  elevation: 5,
                  child: Text("Choose photo"))
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String kok;
    return Scaffold(
      appBar: AppBar(title: Text("DASHBOARD")),
      body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              TextButton(
                  child: Text("Vendre"),
                  onPressed: () {
                    createAlertDialog(context).then((onValue) {
                      SnackBar mySnackBar = SnackBar(
                        content: Text("$onValue en vente"),
                      );
                      widget.ok = onValue;
                                          widget.listtest.add(widget.ok);
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
                  child: Text("Acheter"),
                  onPressed: () {
                    createAlertDialog2(context).then((onValue) {
                      SnackBar mySnackBar = SnackBar(
                        content: Text("$onValue trouvé"),
                      );
                      widget.ok = onValue;
                      widget.listtest.add(widget.ok);
                      Scaffold.of(context).showSnackBar(mySnackBar);
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  )),
              Text("Article mis en vente"),
              //Text(widget.ok),
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
              physics: ClampingScrollPhysics(),
              itemCount: widget.listtest.length,
              itemBuilder: (context, i) {
                return Card(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.listtest[i]),
                )
                    //Image.file(widget.listimage[i])

                    );
                //child: Image.file(widget.image),
              },
              separatorBuilder: (context, i) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.file(widget.listimage[i])
                  )
                );
              },
            )
          ]),
    );
  }
}
