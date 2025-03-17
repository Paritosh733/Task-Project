import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  late String user_name;

  @HiveField(1)
  late String email;

  // UserModel({required this.user_name, required this.email});
}
