// import 'dart:ffi';
// import 'dart:html';

//import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoList extends StatefulWidget {
  const AddTodoList({super.key});

  @override
  State<AddTodoList> createState() => _AddTodoListState();
}

class _AddTodoListState extends State<AddTodoList> {
  @override
  void initState() {
    fetchListData(add);
    super.initState();
  }

  var items = [];
  int add = 1;

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();
  TextEditingController updatetitlecontroller = TextEditingController();
  TextEditingController updatedescontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add List"),
        ),
        body: ListView(
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                hintText: "text",
              ),
            ),
            TextField(
              controller: descontroller,
              decoration: InputDecoration(
                hintText: "Des",
              ),
              minLines: 2,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
            ),
            ElevatedButton(
              onPressed: () {
                return SubmitData();
              },
              child: Text('submit'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     return fetchListData(add);
            //   },
            //   child: Text('show'),
            // ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final id = items[index]['_id'].toString();
                  return ListTile(
                      leading: CircleAvatar(child: Text("${index + 1}")),
                      title: Text(
                        items[index]['title'].toString(),
                      ),
                      subtitle: Text(
                        items[index]['description'].toString(),
                      ),
                      trailing: Container(
                        height: 100,
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: AlertDialog(
                                            title: Text("edit"),
                                            actions: [
                                              TextField(
                                                controller:
                                                    updatetitlecontroller,
                                                decoration: InputDecoration(
                                                  hintText: "title",
                                                ),
                                              ),
                                              TextField(
                                                controller: updatedescontroller,
                                                decoration: InputDecoration(
                                                  hintText: "des",
                                                ),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Update"))
                                            ]),
                                      );
                                    });
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteItemById(id);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
            Text("next page"),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    previousPage();
                    fetchListData(add);
                  },
                  icon: Icon(
                    Icons.navigate_before,
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Text("${add}"),
                ),
                IconButton(
                  onPressed: () {
                    nextPage();
                    fetchListData(add);
                  },
                  icon: Icon(
                    Icons.navigate_next,
                  ),
                )
              ],
            )
          ],
        ));
  }

  void SubmitData() async {
    final title = titlecontroller.text;
    final des = descontroller.text;

    final body = {
      "title": title,
      "description": des,
      "is_completed": false,
    };
    final url = 'http://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final responce = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    // final responce = await http.post(Uri.parse(url));
    if (responce.statusCode == 201) {
      titlecontroller.clear();
      descontroller.clear();
      showSucessMessage("Data Added Successfuly");
      fetchListData(add);
    } else {
      showErroMessage("Erro Not Submitted ");
    }
  }

  void showSucessMessage(message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green.shade300,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErroMessage(message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void fetchListData(int pageNo) async {
    final url = "http://api.nstack.in/v1/todos?page=$pageNo&limit=5";
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    if (responce.statusCode == 200) {
      final finalresponce = jsonDecode(responce.body);
      final result = finalresponce["items"];
      setState(() {
        items = result;
        // print(items);
      });
    } else {
      print("fetch not successful");
    }
  }

// pagination
  void nextPage() {
    setState(() {
      add++;
    });
    print(add);
  }

  void previousPage() {
    setState(() {
      if (add > 1) {
        add--;
      } else {
        print("page can not be less then 1");
      }
    });
    print(add);
  }

  void deleteItemById(String id) async {
    final url = "http://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final responce = await http.delete(uri);
    if (responce.statusCode == 200) {
      final filter = items.where((element) => element['_id'] != id).toList();

      setState(() {
        items = filter;
      });
      print("item has been deleted");
    }
  }
}
