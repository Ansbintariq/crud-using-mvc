import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:post_api/controller/crudController.dart';
import 'package:post_api/view/Edit_page.dart';

import '../controller/controllers.dart';

class UserList extends StatelessWidget {
  UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                TextField(
                  controller: crudcontroller.titlecontroller,
                  decoration: InputDecoration(
                    hintText: "text",
                  ),
                ),
                TextField(
                  controller: crudcontroller.descontroller,
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
                ElevatedButton(
                  onPressed: () {
                    crudcontroller.addUser();
                  },
                  child: Text('submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    crudcontroller.getUser();
                  },
                  child: Text("get"),
                ),
              ],
            ),
            SizedBox(
                height: 500,
                child: Obx(
                  () => crudcontroller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: crudcontroller.users.length,
                          itemBuilder: (context, index) {
                            final userdata = crudcontroller.users[index];
                            final id = userdata.sid;
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                                  width: 400,
                                  color: Colors.green.shade200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(userdata.title.toString()),
                                            Text(
                                              userdata.description.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text("${index + 1}"),
                                            IconButton(
                                              onPressed: () {
                                                crudcontroller
                                                    .deleteUser(id.toString());
                                              },
                                              icon: Icon(Icons.delete),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                crudcontroller.titleEdit.text =
                                                    userdata.title.toString();
                                                crudcontroller.desEdit.text =
                                                    userdata.description
                                                        .toString();
                                                Get.to(() => Editpage(),
                                                    arguments: id);
                                              },
                                              icon: Icon(Icons.edit),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                )),
          ],
        ),
      ),
    );
  }
}
