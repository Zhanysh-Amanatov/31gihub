import 'package:equatable/equatable.dart';
import 'package:finik/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
    on<SingUpRequested>((event, state) async {
      // emit(Loading());
      try {
        await authRepository.signUp(
          email: event.email,
          password: event.password,
        );
      } catch (e) {
        // emit(Unauthenticated());
      }
    });
  }
}
