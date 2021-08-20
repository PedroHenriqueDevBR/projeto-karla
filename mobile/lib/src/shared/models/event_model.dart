import 'package:projeto_karla/src/shared/models/response_model.dart';

class EventModel {
  int? id;
  String title;
  String description;
  String? background;
  String? confirmText;
  String? cancelText;
  DateTime expirationDate;
  String? password;
  List<ResponseModel> responses = [];

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.expirationDate,
    this.background,
    this.confirmText,
    this.cancelText,
    this.password,
  });

  factory EventModel.empty() => EventModel(
        title: '',
        description: '',
        expirationDate: DateTime.now(),
      );

  factory EventModel.fromRestAPI(Map data) => EventModel(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        expirationDate: DateTime.parse(data['expiration_date']),
        background: data['background'],
        confirmText: data['confirm_text'],
        cancelText: data['cancel_text'],
        password: data['password'],
      );

  static List<EventModel> fromResponseList(List<Map> list) {
    List<EventModel> events = [];
    for (Map item in list) {
      events.add(EventModel.fromRestAPI(item));
    }
    return events;
  }
}
