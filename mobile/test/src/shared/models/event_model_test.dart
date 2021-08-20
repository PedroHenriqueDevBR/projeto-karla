import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';

main() {
  test('Should be a event with empty data', () {
    EventModel event = EventModel.empty();
    expect(event.id, isNull);
    expect(event.title.isEmpty, true);
    expect(event.description.isEmpty, true);
    expect(event.background, isNull);
    expect(event.confirmText, isNull);
    expect(event.cancelText, isNull);
    expect(event.expirationDate, isA<DateTime>());
    expect(event.password, isNull);
  });

  test('Should be a EventModel created by fromRestAPI', () {
    Map map = {
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
    };
    EventModel event = EventModel.fromRestAPI(map);
    expect(event.id, isNotNull);
    expect(event.title.isNotEmpty, true);
    expect(event.description.isNotEmpty, true);
    expect(event.background, isNotNull);
    expect(event.confirmText, isNotNull);
    expect(event.cancelText, isNotNull);
    expect(event.expirationDate, isA<DateTime>());
    expect(event.password, isNotNull);
  });

  test('Should be a EventModel List created by fromResponseList', () {
    List<Map> list = [
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
      }
    ];
    List<EventModel> events = EventModel.fromResponseList(list);
    expect(events, isNotNull);
    expect(events.length, equals(2));
  });
}
