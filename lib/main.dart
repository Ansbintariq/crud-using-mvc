import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_api/Add_List.dart';
import 'package:post_api/view/view.dart';

import 'controller/crudController.dart';

void main() {
  Get.put(Crudcontroller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserList(),
    );
  }
}
