@Skip()
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/models/response_model.dart';
import 'package:projeto_karla/src/shared/repositories/response_repository.dart';
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
  ResponseRepository _responseRepository = ResponseRepository(
    client: DioClientService(),
    appData: JwtMock(),
  );

  test('Should register event and return event with ID', () async {
    final event = EventModel.empty();
    event.id = 2;
    final responseModel = ResponseModel.toSave(
      guestName: 'Teste',
      confirm: false,
    );
    final response = await _responseRepository.addResponse(responseModel, event);
    expect(response.id, isNotNull);
  });

  test('Should get a event list', () async {
    final event = EventModel.empty();
    event.id = 2;
    final response = await _responseRepository.getResponsesFromEvent(event);
    expect(response, isA<List<ResponseModel>>());
    expect(response.length, equals(4));
  });

  test('Should delete event', () async {
    final event = EventModel.empty();
    final responseModel = ResponseModel.empty();
    event.id = 7;
    responseModel.id = 10;
    await _responseRepository.deleteResponseFromEvent(responseModel, event);
  });
}
