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

  factory ResponseModel.fromRestAPI(Map data) => ResponseModel(
        id: data['id'],
        guestName: data['guest_name'],
        confirm: data['confirm'],
        responseDate: DateTime.parse(data['response_date']),
      );

  static List<ResponseModel> fromResponseList(List<Map> list) {
    List<ResponseModel> responses = [];
    for (Map item in list) {
      responses.add(ResponseModel.fromRestAPI(item));
    }
    return responses;
  }
}
