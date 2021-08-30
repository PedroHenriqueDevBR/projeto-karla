import 'package:projeto_karla/src/shared/models/event_model.dart';

class UserModel {
  dynamic id;
  String name;
  String username;
  String password;
  List<EventModel> events = [];

  UserModel({
    this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  factory UserModel.empty() => UserModel(
        name: '',
        username: '',
        password: '',
      );

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'username': this.username,
      'password': this.password,
    };
  }

  Map<String, dynamic> toLoginMap() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }
}
