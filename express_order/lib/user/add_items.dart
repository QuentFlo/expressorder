import 'package:express_order/controllers/additems_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonThings {
  static Size? size;
}

class MyAddPage extends StatelessWidget {
  const MyAddPage({ Key? key }) : super(key: key);




Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddController());
    CommonThings.size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un article'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: controller.formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: controller.image == null
                          ? const Text('inserez une image')
                          : Image.file(controller.image!),
                    ),
                    const Divider(),
                    IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: controller.pickerCam),
                    const Divider(),
                    IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: controller.pickerGallery),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Titre',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: controller.validateTitle,
                  onSaved: (value) => controller.name = value,
                ),
                TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: controller.validateDesc,
                  onSaved: (value) => controller.item = value,
                ),
                
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
              
                onPressed: controller.createData,
                child:
                    const Text('Publier', style: TextStyle(color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
