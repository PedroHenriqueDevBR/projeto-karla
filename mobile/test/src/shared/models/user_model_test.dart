import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/models/user_model.dart';

main() {
  test('Should return user with no data', () {
    UserModel user = UserModel.empty();
    expect(user.id, isNull);
    expect(user.name.isEmpty, true);
    expect(user.username.isEmpty, true);
    expect(user.password.isEmpty, true);
  });

  test('Should return user with name, username and password', () {
    UserModel user =
        UserModel(name: 'Pedro', username: 'pedro', password: 'pedro');
    expect(user.id, isNull);
    expect(user.name, equals('Pedro'));
    expect(user.username, equals('pedro'));
    expect(user.password, equals('pedro'));
  });
}
