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
}

class _State extends State<Dashboard> {
  Future<dynamic> createAlertDialog(BuildContext context) {
    TextEditingController customContrller = TextEditingController();
    final picker = ImagePicker();

    OnOpenGallery() async {
      final PickedFile = await picker.getImage(source: ImageSource.gallery);

      if (PickedFile != null) {
        File image = File(PickedFile.path);
        final fileBytes = image.readAsBytesSync();
        final data = await readExifFromBytes(fileBytes, details: false);
      }
      else
        print('No image selected.');
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Article à vendre"),
            content: TextFormField(
              controller: customContrller,
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(customContrller.text.toString());
                  },
                  elevation: 5,
                  child: Text("Submit")
                  ),
              MaterialButton(
                  onPressed: () {
                    OnOpenGallery();
                },
                elevation: 5,
                child: Text("Choose photo")
                )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("DASHBOARD")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                child: Text("Vendre"),
                onPressed: () {
                  createAlertDialog(context).then((onValue) {
                    SnackBar mySnackBar = SnackBar(
                      content: Text("$onValue en vente"),
                    );
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
                  createAlertDialog(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueGrey),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ))
          ],
        )));
  }
}
