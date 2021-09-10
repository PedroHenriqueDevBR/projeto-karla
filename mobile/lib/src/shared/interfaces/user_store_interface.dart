import '../models/user_model.dart';

abstract class IUserStorage {
  Future<bool> userIsLogged();

  Future<bool> loginUser(UserModel user);

  Future<void> logout();

  Future<void> registerUser(UserModel user);
}
