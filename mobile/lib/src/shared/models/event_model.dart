import 'response_model.dart';

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

  factory EventModel.fromRestAPI(dynamic data) => EventModel(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        expirationDate: DateTime.parse(data['expiration_date']),
        background: data['background'],
        confirmText: data['confirm_text'],
        cancelText: data['cancel_text'],
        password: data['password'],
      );

  String get formatedDate =>
      '${formatDateToShow(expirationDate.day)}/${formatDateToShow(expirationDate.month)}/${expirationDate.year}';

  String formatDateToShow(int info) {
    if (info < 10) return '0$info';
    return '$info';
  }

  String get confirmTextFormated => confirmText != null ? confirmText! : 'Confirmado';

  String get cancelTextFormated => cancelText != null ? cancelText! : 'Negado';

  static List<EventModel> fromResponseList(List<dynamic> list) {
    List<EventModel> events = [];
    for (dynamic item in list) {
      final event = EventModel.fromRestAPI(item);
      event.responses = ResponseModel.fromResponseList(item['responses']);
      events.add(event);
    }
    return events;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': this.title,
      'description': this.description,
      'expiration_date': this.expirationDate.toIso8601String(),
    };
    if (this.background != null) map['background'] = this.background;
    if (this.confirmText != null) map['confirm_text'] = this.confirmText;
    if (this.cancelText != null) map['cancel_text'] = this.cancelText;
    if (this.password != null) map['password'] = this.password;
    return map;
  }
}
