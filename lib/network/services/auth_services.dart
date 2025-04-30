import 'package:firebase_auth/firebase_auth.dart';
import 'package:emcus/models/user_model.dart';

abstract class AuthServiceRepository {
  Future<void> createUser(UserModel user);
  Future<void> signInUser(UserModel user);
  Future<void> logout();
}

class AuthServiceImp extends AuthServiceRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      firebaseAuth.currentUser?.updateDisplayName(user.userName);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signInUser(UserModel user) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
