import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:post_api/Model/crudModel.dart';
import 'package:post_api/controller/controllers.dart';

class UsersRepo {
  deleteUser(id) async {
    final url = "http://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final responce = await http.delete(uri);
    if (responce.statusCode == 200) {
      print("deleted");
      // final filter = crudcontroller.users.where((element) => element['_id'] != id).toList();
    }
  }

  getUser() async {
    final url = "http://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    if (responce.statusCode == 200) {
      final finalrecord = jsonDecode(responce.body);
      //   print(finalrecord['items']);
      crudcontroller.users.value = finalrecord['items']
          .map<CrudModel>((v) => CrudModel.fromJson(v))
          .toList();

      print("Data Get successfuly");
    } else {
      print("Data Not Get successfuly");
    }
  }

  addUser(String title, String des) async {
    final userData = CrudModel(
      title: title,
      description: des,
      isCompleted: false,
    );

    final url = 'http://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final responce = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData.toJson()),
    );
    if (responce.statusCode == 201) {
      //      titlecontroller.clear();
      //  descontroller.clear();
      print("Data has been submitted ");
      return true;
    } else {
      print("Erro Data is Not Submitted ");
      return false;
    }
  }

  updateUser(String title, String des, String id) async {
    final updatedData = CrudModel(
      title: title,
      description: des,
      isCompleted: false,
    );
    print(id);
    print(title);

    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final responce = await http.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updatedData.toJson()),
    );
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      print("Data has been Updated ");
      return true;
    } else {
      print("Erro Data is Not Updated ");
      return false;
    }
  }
}
