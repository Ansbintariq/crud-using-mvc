import 'package:flutter/material.dart';
import 'package:post_api/controller/controllers.dart';
import 'package:get/get.dart';

class Editpage extends StatelessWidget {
  const Editpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit page"),
      ),
      body: Column(
        children: [
          TextField(
            controller: crudcontroller.titleEdit,
            decoration: InputDecoration(
              hintText: "text",
            ),
          ),
          TextField(
            controller: crudcontroller.desEdit,
            decoration: InputDecoration(
              hintText: "Description",
            ),
            minLines: 2,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
          ),
          ElevatedButton(
            onPressed: () {
              var id = Get.arguments;
              crudcontroller.updateUser(id);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
