import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/repositories/event_repository.dart';
import 'package:projeto_karla/src/shared/services/app_data_interface.dart';
import 'package:projeto_karla/src/shared/services/client_http_interface.dart';
import 'package:projeto_karla/src/shared/services/http_response_model.dart';

class HttpMock extends Mock implements IClientHTTP {}

class JwtMock extends Mock implements IAppData {}

main() {
  final _client = HttpMock();
  final _appData = JwtMock();
  EventRepository _repository = EventRepository(
    client: _client,
    appData: _appData,
  );

  test('Should return a EventModel with ID after saved', () async {
    when(() => _client.post(any(), any(), jwtKey: any(named: 'jwtKey'))).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: addEventResponse,
          headers: {},
        ));
    when(() => _appData.getJWT()).thenAnswer((_) async => 'jwtkey');
    EventModel event = EventModel(
      title: 'Titulo',
      description: '',
      expirationDate: DateTime.parse('2021-10-25'),
    );
    final response = await _repository.addEvent(event);
    expect(response, isA<EventModel>());
    expect(response.id, equals(5));
  });

  test('Should return a list of EventModel', () async {
    when(() => _client.get(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: eventListResponse,
          headers: {},
        ));
    when(() => _appData.getJWT()).thenAnswer((_) async => 'jwtkey');
    final response = await _repository.getAllEvents();
    expect(response.isNotEmpty, true);
    expect(response.length, equals(5));
  });

  test('Should run a update data', () async {
    when(() => _client.put(any(), any(), jwtKey: any(named: 'jwtKey'))).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: updateEventResponse,
          headers: {},
        ));
    when(() => _appData.getJWT()).thenAnswer((_) async => 'jwtkey');
    EventModel event = EventModel(
      id: 6,
      title: 'Updated again',
      description: 'text',
      expirationDate: DateTime.parse('2021-10-26'),
      confirmText: 'Posso ir',
    );
    await _repository.updateEvent(event);
  });

  test('Should delete EventModel', () async {
    when(() => _client.delete(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: {},
          headers: {},
        ));
    when(() => _appData.getJWT()).thenAnswer((_) async => 'jwtkey');
    final event = EventModel.empty();
    event.id = 7;
    await _repository.deleteEvent(event);
  });
}

Map addEventResponse = {
  "id": 5,
  "title": "Evento com nulo",
  "description": "Sem descrição",
  "avatar": null,
  "background": null,
  "confirm_text": null,
  "cancel_text": null,
  "expiration_date": "2021-08-27T19:04:33.143071",
  "password": "",
  "person": 1
};

Map updateEventResponse = {
  "title": "E",
  "description": "Sem descrição",
  "avatar": null,
  "background": null,
  "confirm_text": "Pode contar comigo",
  "cancel_text": null,
  "expiration_date": "2021-08-28T19:04:33.143071",
  "password": "",
  "person": 1
};

List<Map> eventListResponse = [
  {
    "id": 2,
    "title": "Evento 03",
    "description": "Sem descrição",
    "avatar": null,
    "background":
        "https://images.pexels.com/photos/7078700/pexels-photo-7078700.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "confirm_text": "Sim",
    "cancel_text": "Não",
    "expiration_date": "2021-08-27T19:04:33.143071",
    "password": "",
    "person": 1
  },
  {
    "id": 3,
    "title": "Teste",
    "description": "teste",
    "avatar": null,
    "background": null,
    "confirm_text": null,
    "cancel_text": null,
    "expiration_date": "2021-08-21",
    "password": "",
    "person": 1
  },
  {
    "id": 5,
    "title": "Evento com nulo",
    "description": "Sem descrição",
    "avatar": null,
    "background": null,
    "confirm_text": null,
    "cancel_text": null,
    "expiration_date": "2021-08-27T19:04:33.143071",
    "password": "",
    "person": 1
  },
  {
    "id": 6,
    "title": "Updated again",
    "description": "text",
    "avatar": null,
    "background": null,
    "confirm_text": "Posso ir",
    "cancel_text": null,
    "expiration_date": "2021-08-26T00:00:00.000",
    "password": "",
    "person": 1
  },
  {
    "id": 8,
    "title": "Titulo",
    "description": "",
    "avatar": null,
    "background": null,
    "confirm_text": null,
    "cancel_text": null,
    "expiration_date": "2021-08-25T00:00:00.000",
    "password": "",
    "person": 1
  }
];
