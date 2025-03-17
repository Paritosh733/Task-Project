import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_project/addUser.dart';

import 'Model/boxes.dart';
import 'Model/user_model.dart';
import 'constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Hive.openBox<UserModel>('usermodel');
    // print(Hive.isBoxOpen('usermodel'));
    // print(Hive.box("usermodel"));
    // Hive.openBox('user_model');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder<Box<UserModel>>(
          valueListenable: Boxes.getUserInfo().listenable(),
          builder: (context, box, _) {
            final user = box.values.toList().cast<UserModel>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title("Users List"),
                      commonButton("Add", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdduserPage(
                                      edit: "false",
                                    )));
                      }, canPressbtn: true)
                    ],
                  ),
                  for (var i in user) buildContent(i.user_name, i.email, i),
                ]),
              ),
            );
          }),
    );
  }

  Future deleteUserInfo(UserModel userinfo) async {
    print(userinfo);
    print(userinfo.user_name);
    print(userinfo.key);
    final box = Boxes.getUserInfo();
    box.delete(userinfo.key);
    userinfo.delete();
    setState(() {});
    return Future(() => true);
  }

  Widget buildContent(String name, String email, user) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: Offset(1.0, 1.0),
                blurRadius: 1.5,
                spreadRadius: 1.5)
          ]),
      child: Column(
        children: [
          // cText("${i}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cText(name, fontSize: 16, weight: FontWeight.w500),
              SizedBox(
                width: 10,
              ),
              cText(email, fontSize: 16, weight: FontWeight.w500),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonIconButton(Icons.edit, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdduserPage(
                              edit: "true",
                              data: user,
                            )));
              }, true),
              SizedBox(
                width: 10,
              ),
              commonIconButton(Icons.delete, () {
                deleteUserInfo(user);
              }, false)
            ],
          ),
        ],
      ),
    );
  }
}
