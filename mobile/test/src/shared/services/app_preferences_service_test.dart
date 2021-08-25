import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/services/app_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  final _appPreferences = AppPreferenceService();

  test('Should save a jwt key', () async {
    _appPreferences.setJWT('jwtkey');
  });

  test('Should return a jwt key', () async {
    SharedPreferences.setMockInitialValues({'jwt': 'jwtkey'});
    final response = await _appPreferences.getJWT();
    expect(response, equals('jwtkey'));
  });
}
