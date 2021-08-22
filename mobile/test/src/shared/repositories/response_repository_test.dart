import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/models/response_model.dart';
import 'package:projeto_karla/src/shared/repositories/response_repository.dart';
import 'package:projeto_karla/src/shared/services/app_data_interface.dart';
import 'package:projeto_karla/src/shared/services/client_http_interface.dart';
import 'package:projeto_karla/src/shared/services/http_response_model.dart';

class HttpMock extends Mock implements IClientHTTP {}

class JwtMock extends Mock implements IAppData {}

main() {
  final _client = HttpMock();
  final _appData = JwtMock();
  ResponseRepository _responseRepository = ResponseRepository(
    client: _client,
    appData: _appData,
  );

  test('Should register event and return event with ID', () async {
    when(
      () => _client.post(any(), any(), jwtKey: any(named: 'jwtKey')),
    ).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: addResponse,
          headers: {},
        ));
    final event = EventModel.empty();
    final responseModel = ResponseModel.toSave(guestName: 'Teste', confirm: false);
    event.id = 2;
    final response = await _responseRepository.addResponse(responseModel, event);
    expect(response.id, isNotNull);
  });

  test('Should get a event list', () async {
    when(
      () => _client.get(any(), jwtKey: any(named: 'jwtKey')),
    ).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: responseList,
          headers: {},
        ));
    when(() => _appData.getJWT()).thenAnswer((_) async => 'jwtkey');
    final event = EventModel.empty();
    event.id = 2;
    final response = await _responseRepository.getResponsesFromEvent(event);
    expect(response, isA<List<ResponseModel>>());
    expect(response.length, equals(4));
  });

  test('Should delete event', () async {
    when(
      () => _client.delete(any(), jwtKey: any(named: 'jwtKey')),
    ).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: {},
          headers: {},
        ));
    when(() => _appData.getJWT()).thenAnswer((_) async => 'jwtkey');
    final event = EventModel.empty();
    final responseModel = ResponseModel.empty();
    event.id = 7;
    responseModel.id = 10;
    await _responseRepository.deleteResponseFromEvent(responseModel, event);
  });
}

Map addResponse = {
  "id": 10,
  "response_date": "2021-08-21T23:28:25.365259-03:00",
  "guest_name": "Kakaroto",
  "confirm": true,
  "event": 7
};

List<Map> responseList = [
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
  {"id": 5, "response_date": "2021-08-18T22:33:11.375517-03:00", "guest_name": "Kakaroto", "confirm": true, "event": 2},
  {"id": 9, "response_date": "2021-08-21T22:14:49.545353-03:00", "guest_name": "Teste", "confirm": false, "event": 2}
];
