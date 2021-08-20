import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/models/response_model.dart';

main() {
  test('Should be a ResponseMode with data', () {
    ResponseModel response = ResponseModel(
        guestName: 'Pedro Henrique',
        confirm: true,
        responseDate: DateTime.now());
    expect(response.guestName, equals('Pedro Henrique'));
    expect(response.confirm, equals(true));
    expect(response.responseDate, isA<DateTime>());
  });

  test('Should a ResponseModel created by fromRestAPI', () {
    Map map = {
      "id": 5,
      "response_date": "2021-08-18T22:33:11.375517-03:00",
      "guest_name": "Kakaroto",
      "confirm": true,
      "event": 2
    };

    ResponseModel response = ResponseModel.fromRestAPI(map);
    expect(response.id, isNotNull);
    expect(response.id, equals(5));
    expect(response.guestName, equals('Kakaroto'));
    expect(response.confirm, equals(true));
    expect(response.responseDate, isA<DateTime>());
  });

  test('Should a ResponseModel created by fromResponseList', () {
    List<Map> list = [
      {
        "id": 1,
        "response_date": "2021-08-18T10:43:16.593819-03:00",
        "guest_name": "Pedro Henrique",
        "confirm": true,
        "event": 2
      },
      {
        "id": 3,
        "response_date": "2021-08-18T11:15:50.500197-03:00",
        "guest_name": "Pedro Henrique",
        "confirm": true,
        "event": 2
      },
      {
        "id": 5,
        "response_date": "2021-08-18T22:33:11.375517-03:00",
        "guest_name": "Kakaroto",
        "confirm": true,
        "event": 2
      }
    ];

    List<ResponseModel> responses = ResponseModel.fromResponseList(list);
    expect(responses, isA<List>());
    expect(responses.length, equals(3));
  });
}
