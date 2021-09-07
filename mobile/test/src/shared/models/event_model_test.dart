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
        "id": 11,
        "title": "Evento",
        "description": "a descrição do evento",
        "avatar": null,
        "background":
            "https://images.pexels.com/photos/5065790/pexels-photo-5065790.jpeg?cs=srgb&dl=pexels-kamaji-ogino-5065790.jpg&fm=jpg",
        "confirm_text": "Estou nessa",
        "cancel_text": "Nem fedendo",
        "expiration_date": "2021-09-11T00:00:00.000",
        "password": "1234",
        "person": 1,
        "responses": [
          {"id": 13, "response_date": "2021-09-07T09:56:41.015954-03:00", "guest_name": "Kakaroto", "confirm": true}
        ]
      },
      {
        "id": 12,
        "title": "Aniversário da Karla",
        "description": "Descrição do aniversário da karla",
        "avatar": null,
        "background":
            "https://images.pexels.com/photos/1629781/pexels-photo-1629781.jpeg?cs=srgb&dl=pexels-ilargian-faus-1629781.jpg&fm=jpg",
        "confirm_text": "Estou nessa",
        "cancel_text": "Não posso",
        "expiration_date": "2021-09-11T00:00:00.000",
        "password": "1234",
        "person": 1,
        "responses": []
      }
    ];
    List<EventModel> events = EventModel.fromResponseList(list);
    expect(events, isNotNull);
    expect(events.length, equals(2));
  });
}
