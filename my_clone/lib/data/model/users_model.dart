import 'package:uuid/uuid.dart';

class UserModel {
  // int? id;
  // String? name;
  // String? photo;
  // String? time;
  // String? message;
  // bool isChecked;

  String? id;
  String? name;
  String? photo;
  String? time;
  String? message;
  bool isChecked;

  UserModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.time,
    required this.message,
    this.isChecked = false,
  });

  // UserModel.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       name = json['name'],
  //       photo = json['photo'],
  //       time = json['time'],
  //       message = json['message'],
  //       isChecked = json['isChecked'] ?? false;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = const Uuid().v4(),
        name = json['name'],
        photo = json['photo'],
        time = json['time'],
        message = json['message'],
        isChecked = json['isChecked'] ?? false;
}
