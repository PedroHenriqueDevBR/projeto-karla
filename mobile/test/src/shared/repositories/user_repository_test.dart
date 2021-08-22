@Skip()
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/models/user_model.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';
import 'package:projeto_karla/src/shared/services/http_client_service.dart';

main() {
  late UserRepository _userRepository = UserRepository(client: HTTPClientService());

  test('Should be a true on register user', () async {
    UserModel user = UserModel(name: 'Pedro Henrique', username: 'pedro5', password: 'pedro123');
    await _userRepository.registerUser(user);
  });

  test('Should login user', () async {
    UserModel user = UserModel(name: 'Pedro', username: 'kakaroto', password: 'kakaroto');
    final response = await _userRepository.loginAndResponseJWTKey(user);
    expect(response, isA<String>());
  });
}
