@Skip()
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/repositories/event_repository.dart';
import 'package:projeto_karla/src/shared/services/app_data_interface.dart';
import 'package:projeto_karla/src/shared/services/dio_client_service.dart';

class JwtMock implements IAppData {
  @override
  Future<String> getJWT() async {
    return 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI5ODU4NzkwLCJqdGkiOiJmZmI0NGE1MWNlZDA0MTc5OTdjMTg5ZDcwZmI1MWRmOSIsInVzZXJfaWQiOjF9.hfGwCmSbRXD-Y-kiQPuPAtgBZn3YlDkVcQ8NVU5F8ck';
  }

  @override
  Future<void> setJWT(String jwt) => throw UnimplementedError();
}

main() {
  EventRepository _repository = EventRepository(
    client: DioClientService(),
    appData: JwtMock(),
  );

  test('Should return a EventModel with ID after saved', () async {
    EventModel event = EventModel(
      title: 'Titulo',
      description: '',
      expirationDate: DateTime.parse('2021-08-25'),
    );
    final response = await _repository.addEvent(event);
    expect(response, isA<EventModel>());
    expect(response.id, isNotNull);
  });

  test('Should return a list of EventModel', () async {
    final response = await _repository.getAllEvents();
    expect(response.isNotEmpty, true);
  });

  test('Should run a update data', () async {
    EventModel event = EventModel(
      id: 6,
      title: 'Updated again',
      description: 'text',
      expirationDate: DateTime.parse('2021-08-26'),
      confirmText: 'Posso ir',
    );
    await _repository.updateEvent(event);
  });

  test('Should delete EventModel', () async {
    final event = EventModel.empty();
    event.id = 7;
    await _repository.deleteEvent(event);
  });
}
