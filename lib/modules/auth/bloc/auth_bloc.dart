import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/repositories/auth_repository.dart';
import '../../../service_locator.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = sl<AuthRepository>();
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpLoading());
      try {
        await _authRepository.createNewUser(event.user);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });

    on<SignInSubmitted>((event, emit) async {
      emit(SignInLoading());
      try {
        await _authRepository.signInUser(event.user);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure(e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      await FirebaseAuth.instance.signOut();
      emit(Unauthenticated());
    });
  }
}
