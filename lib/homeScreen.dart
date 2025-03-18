import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:task_project/addUser.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
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
    verifybox();
    // Hive.openBox<UserModel>('usermodel');
    // print(Hive.isBoxOpen('usermodel'));
    // print(Hive.box("usermodel"));
    // Hive.openBox('user_model');
  }

  void verifybox() async {
    if (!Hive.isBoxOpen('user_model')) {
      await Hive.openBox<UserModel>('userModel');
    }
  }

  void showAnimationAndPop(BuildContext context, UserModel user) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => Center(
        child: Dialog(
          backgroundColor: Colors.white,
          child: Container(
            height: 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Are you sure you want to delete data ?",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Lottie.asset(
                  'assets/animation/delete.json', // Replace with your Lottie animation file
                  width: 95,
                  height: 95,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: commonButton("No", () {
                        Navigator.pop(context);
                      }),
                    ),
                    Container(
                      width: 100,
                      child: commonButton("Yes", () {
                        deleteUserInfo(user);
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, UserModel user) {
    AwesomeDialog(
        context: context,
        keyboardAware: true,
        dismissOnBackKeyPress: false,
        // padding: const EdgeInsets.all(20.0),
        width: MediaQuery.sizeOf(context).width,
        dialogType: DialogType.error,
        animType: AnimType.SCALE,
        title: 'Confirm Delete',
        desc: 'Are you sure you want to delete data ?',
        customHeader: Lottie.asset(
          'assets/animation/delete.json', // Replace with your Lottie animation file
          width: 95,
          height: 95,
        ),
        titleTextStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        descTextStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        btnCancelColor: Colors.blueAccent,
        btnOkColor: Colors.blueAccent,
        btnOkText: "Ok",
        btnCancelText: "Cancel",
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          deleteUserInfo(user);
        }).show();
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
    verifybox();
    print(userinfo);
    print(userinfo.user_name);
    print(userinfo.key);
    final box = Boxes.getUserInfo();
    box.delete(userinfo.key);
    // Navigator.pop(context);
    userinfo.delete();
    setState(() {});

    return Future(() => true);
  }

  Widget buildContent(String name, String email, user) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
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
              }, true, "Edit"),
              SizedBox(
                width: 10,
              ),
              commonIconButton(Icons.delete, () {
                showDeleteDialog(context, user);
              }, false, "Delete")
            ],
          ),
        ],
      ),
    );
  }
}
