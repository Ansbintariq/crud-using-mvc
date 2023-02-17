// import 'dart:convert';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_api/Model/crudModel.dart';
// import 'package:http/http.dart' as http;

import '../repositry/users.dart';

class Crudcontroller extends GetxController {
  //create instance
  static Crudcontroller instance = Get.find();
  var users = <CrudModel>[].obs;
  var isLoading = false.obs;
  // RxInt updateUserIndex = 15000.obs;

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();
  TextEditingController titleEdit = TextEditingController();
  TextEditingController desEdit = TextEditingController();

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  addUser() async {
    bool res =
        await UsersRepo().addUser(titlecontroller.text, descontroller.text);
    if (res == true) {
      titlecontroller.clear();
      descontroller.clear();
      getUser();
    }
  }

  getUser() async {
    isLoading.value = true;
    await UsersRepo().getUser();
    isLoading.value = false;
  }

  deleteUser(id) async {
    await UsersRepo().deleteUser(id);
    getUser();
  }

  updateUser(id) async {
    bool res = await UsersRepo().updateUser(titleEdit.text, desEdit.text, id);
    // print("id to update record = $id");
    if (res == true) {
      titlecontroller.clear();
      descontroller.clear();
      getUser();
    }
  }
}
