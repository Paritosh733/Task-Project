import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import 'Model/boxes.dart';
import 'Model/user_model.dart';
import 'constants.dart';

class AdduserPage extends StatefulWidget {
  AdduserPage({super.key, required this.edit, this.data});

  String edit;
  UserModel? data;

  @override
  State<AdduserPage> createState() => _AdduserPageState();
}

class _AdduserPageState extends State<AdduserPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var salaryController = TextEditingController();

  List<bool> showValidate = List.generate(3, (index) => false);

  @override
  void initState() {
    super.initState();
    verifybox();
    // Future.delayed(Duration.zero, () async {
    //   if (!Hive.isBoxOpen('user_model')) {
    //     await Hive.openBox<UserModel>('userModel');
    //   } // Call your async function properly
    // });
    if (widget.edit == "true") controlFields();
  }

  void verifybox() async {
    if (!Hive.isBoxOpen('user_model')) {
      await Hive.openBox<UserModel>('userModel');
    }
  }

  void controlFields() {
    setState(() {
      nameController.text = widget.data!.user_name;
      emailController.text = widget.data!.email;
    });
  }

  void validate() async {
    showValidate[0] = nameController.text.isEmpty;
    showValidate[1] = emailController.text.isEmpty;
    showValidate[2] = salaryController.text.isEmpty;
    if (showValidate.any((_element) => _element == true)) {
      print("validate true");
    } else {
      // Navigator.push(
      // context, MaterialPageRoute(builder: (context) => const LandScreen()));
    }
    setState(() {});
  }

  Future addUserInfo(String user_name, String email) {
    print("ADD USER INFO");
    final userInfo = UserModel()
      ..user_name = user_name
      ..email = email;
    final box = Boxes.getUserInfo();
    box.add(userInfo);
    // showAnimationAndPop(context);
    print(user_name);
    Navigator.of(context).pop();
    return Future(() => true);
  }

  void editUserInfo(UserModel userinfo, String user_name, String email) {
    print("Edit user info");
    setState(() {
      userinfo.user_name = user_name;
      userinfo.email = email;
    });
    final box = Boxes.getUserInfo();
    box.put(userinfo.key, userinfo);
    userinfo.save();
    print(userinfo.email);
    print(email);
    Navigator.pop(context);
  }

  // void showAnimationAndPop(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Prevent dismissing by tapping outside
  //     builder: (context) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: Center(
  //         child: Lottie.asset(
  //           'assets/animation2.json', // Replace with your Lottie animation file
  //           width: 150,
  //           height: 150,
  //         ),
  //       ),
  //     ),
  //   );
  //
  //   Future.delayed(const Duration(seconds: 5), () {
  //     Navigator.pop(context); // Close the animation dialog
  //     // Navigator.pop(context); // Pop the screen
  //   });
  // }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: (widget.edit == "true") ? Text("Edit User") : Text("Add User"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textFormField(nameController, "Enter Full Name *",
                showValidate: showValidate[0]),
            textFormField(emailController, "Enter Email *",
                showValidate: showValidate[1]),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: commonButton(
                (widget.edit == "true") ? "Update" : "Add",
                () {
                  (widget.edit == "true")
                      ? editUserInfo(widget.data!, nameController.text,
                          emailController.text)
                      : addUserInfo(nameController.text, emailController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
