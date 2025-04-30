import '../../service_locator.dart';
import '../services/auth_services.dart';
import '../../models/user_model.dart';

abstract class AuthRepository {
  Future<void> createNewUser(UserModel user);
  Future<void> signInUser(UserModel user);
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  final AuthServiceRepository _authService = sl<AuthServiceRepository>();

  @override
  Future<void> createNewUser(UserModel user) async {
    try {
      return await _authService.createUser(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signInUser(UserModel user) async {
    try {
      return await _authService.signInUser(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      return await _authService.logout();
    } catch (e) {
      rethrow;
    }
  }
}
