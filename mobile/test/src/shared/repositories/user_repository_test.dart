import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/exceptions/invalid_data_exception.dart';
import 'package:projeto_karla/src/shared/interfaces/app_data_interface.dart';
import 'package:projeto_karla/src/shared/interfaces/client_http_interface.dart';
import 'package:projeto_karla/src/shared/models/user_model.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';
import 'package:projeto_karla/src/shared/services/http_response_model.dart';
import 'package:mocktail/mocktail.dart';

class HttpMock extends Mock implements IClientHTTP {}

class JwtMock extends Mock implements IAppData {}

main() {
  final _client = HttpMock();
  final _appData = JwtMock();
  UserRepository _userRepository = UserRepository(
    client: _client,
    appData: _appData,
  );

  test('Should be error on invalid data', () async {
    final user = UserModel(name: 'a', username: 'a', password: 'a');
    expect(() async => await _userRepository.registerUser(user), throwsA(TypeMatcher<InvalidDataException>()));
  });

  test('Should be a true on register user', () async {
    when(() => _client.post(any(), any())).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: registerUserResponse,
          headers: {},
        ));
    UserModel user = UserModel(
      name: 'Pedro Henrique',
      username: 'pedro8',
      password: 'pedro123',
    );
    await _userRepository.registerUser(user);
  });

  test('Should login user', () async {
    UserModel user = UserModel(name: 'Pedro', username: 'kakaroto', password: 'kakaroto');
    when(() => _client.post(any(), any())).thenAnswer((_) async => HttpResponseModel(
          statusCode: 200,
          data: loginResponse,
          headers: {},
        ));
    when(() => _appData.setJWT(any())).thenAnswer((_) async {});
    await _userRepository.loginUser(user);
  });
}

Map registerUserResponse = {
  "name": "Pedro Henrique",
  "username": "kakaroto",
  "password": "kakaroto",
};

Map loginResponse = {
  "refresh":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYzMTkzMjM5MCwianRpIjoiZmVmNWFmZWNjOTdkNDE5M2JiMWM2M2U0NzA2MjFjMTYiLCJ1c2VyX2lkIjoxfQ.xgxWolul7o96CPaTrbYAITc1nmY1rshRpIGg1UdbUFE",
  "access":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI5ODU4NzkwLCJqdGkiOiJmZmI0NGE1MWNlZDA0MTc5OTdjMTg5ZDcwZmI1MWRmOSIsInVzZXJfaWQiOjF9.hfGwCmSbRXD-Y-kiQPuPAtgBZn3YlDkVcQ8NVU5F8ck"
};
