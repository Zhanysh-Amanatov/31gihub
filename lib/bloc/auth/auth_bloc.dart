import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(InitialAuthState()) {
    on<SignUpEvent>(_mapSignUpEventToState);
  }
  void _mapSignUpEventToState(
      SignUpEvent event, Emitter<AuthState> emit) async {
    print('Received event: $event');

    try {
      emit(LoadingState());
      await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await _auth.currentUser?.sendEmailVerification();
      emit(AuthenticatedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Stream<AuthState> _mapLoginEventToState(LoginEvent event) async* {
    try {
      yield LoadingState();
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      yield AuthenticatedState();
    } catch (e) {
      yield ErrorState(error: e.toString());
    }
  }
}






// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository authRepository;

//   AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
//     on<SingUpRequested>((event, state) async {
//       // emit(Loading());
//       try {
//         await authRepository.signUp(
//           email: event.email,
//           password: event.password,
//         );
//       } catch (e) {
//         // emit(Unauthenticated());
//       }
//     });
//   }
// }
