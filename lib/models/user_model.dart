
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;

  UserModel(
      {required this.email,
      required this.password,
      required this.uid,
      required this.name});



}
//
