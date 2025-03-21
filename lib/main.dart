import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_project/splashScreen.dart';

import 'Model/user_model.dart';
import 'homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userModel');
  if (!Hive.isBoxOpen('user_model')) {
    await Hive.openBox<UserModel>('userModel');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: "CRUD Using Hive",
      ),
    );
  }
}
