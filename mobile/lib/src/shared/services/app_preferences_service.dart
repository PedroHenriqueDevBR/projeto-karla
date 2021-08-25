import 'package:projeto_karla/src/shared/exceptions/invalid_data_exception.dart';
import 'package:projeto_karla/src/shared/services/app_data_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferenceService implements IAppData {
  final key = 'jwt';
  Future<SharedPreferences> _getPreferencesInstance() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<String> getJWT() async {
    try {
      final instance = await _getPreferencesInstance();
      String? response = instance.getString(key);
      if (response == null) throw InvalidDataException(errors: ['Usuário não logado']);
      return response;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> setJWT(String jwt) async {
    try {
      final instace = await _getPreferencesInstance();
      instace.setString(key, jwt);
    } catch (error) {
      throw error;
    }
  }
}
