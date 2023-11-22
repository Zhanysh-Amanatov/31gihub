/*External dependencies*/
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*Local dependencies*/
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(InitialAuthState()) {
    on<SignUpEvent>(_mapSignUpEventToState);
    on<LoginEvent>(_mapLoginEventToState);
    on<ForgotPasswordEvent>(_mapForgotPasswordEventToState);
  }

  void _mapSignUpEventToState(
      SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await _auth.currentUser?.sendEmailVerification();
      emit(const AuthernticationSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _mapLoginEventToState(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(const AuthernticationSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }

  void _mapForgotPasswordEventToState(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      await _auth.sendPasswordResetEmail(email: event.email);
      emit(ForgotPasswordState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(error: e.code));
    }
  }
}
