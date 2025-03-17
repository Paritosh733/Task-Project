import 'package:hive/hive.dart';
import 'package:task_project/Model/user_model.dart';

class Boxes {
  static Box<UserModel> getUserInfo() => Hive.box<UserModel>('userModel');
}
