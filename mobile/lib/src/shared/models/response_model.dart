class ResponseModel {
  int? id;
  DateTime responseDate;
  String guestName;
  bool confirm;

  ResponseModel({
    this.id,
    required this.guestName,
    required this.confirm,
    required this.responseDate,
  });

  factory ResponseModel.empty() => ResponseModel(
        guestName: '',
        confirm: false,
        responseDate: DateTime.now(),
      );

  factory ResponseModel.toSave({
    required String guestName,
    required bool confirm,
  }) {
    return ResponseModel(
      guestName: guestName,
      confirm: confirm,
      responseDate: DateTime.now(),
    );
  }

  factory ResponseModel.fromRestAPI(dynamic data) => ResponseModel(
        id: data['id'],
        guestName: data['guest_name'],
        confirm: data['confirm'],
        responseDate: DateTime.parse(data['response_date']),
      );

  static List<ResponseModel> fromResponseList(List<dynamic> list) {
    List<ResponseModel> responses = [];
    for (dynamic item in list) {
      responses.add(ResponseModel.fromRestAPI(item));
    }
    return responses;
  }

  Map<String, dynamic> toMap() => {
        'guest_name': this.guestName,
        'confirm': this.confirm,
      };
}
