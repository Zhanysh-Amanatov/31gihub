// ignore_for_file: avoid_print
/*External dependencies*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*Local dependencies*/
import 'package:finik/services/authentication_repository.dart';
import 'package:finik/user.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStarted) {
        UserModel user = await _authenticationRepository.getCurrentUser().first;
        if (user.uid != "uid") {
          // String? displayName =
          // await _authenticationRepository.retrieveUserName(user);
          // emit(AuthenticationSuccess(displayName: displayName));
        } else {
          emit(AuthenticationFailure());
        }
      } else if (event is AuthenticationSignedOut) {
        await _authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }

  // final AuthService authService = AuthService();

  // AuthenticationBloc() : super(AuthenticationInitialState()) {
  //   on<AuthenticationEvent>((event, emit) {});

  //   on<SignUpEvent>((event, emit) async {
  //     emit(AuthenticationLoadingState(isLoading: true));
  //     try {
  //       final UserModel? user =
  //           await authService.signUp(event.email, event.password);
  //       if (user != null) {
  //         emit(AuthenticationSuccessState(user));
  //       } else {
  //         emit(AuthenticationFailureState('create user failed'));
  //       }
  //     } catch (e) {
  //       print(e.toString());
  //       emit(AuthenticationLoadingState(isLoading: false));
  //     }
  //   });

  //   on<LoginEvent>((event, emit) async {
  //     emit(AuthenticationLoadingState(isLoading: true));
  //     try {
  //       final UserModel? user =
  //           await authService.signIn(event.email, event.password);
  //       if (user != null) {
  //         emit(AuthenticationSuccessState(user));
  //       } else {
  //         emit(AuthenticationFailureState('create user failed'));
  //       }
  //     } catch (e) {
  //       print(e.toString());
  //       emit(AuthenticationLoadingState(isLoading: false));
  //     }
  //   });

  //   on<ForgotPasswordEvent>((event, emit) async {
  //     emit(AuthenticationLoadingState(isLoading: true));
  //     try {
  //       final UserModel? user = await authService.forgotPassword(event.email);
  //       if (user != null) {
  //         emit(AuthenticationSuccessState(user));
  //       }
  //     } catch (e) {
  //       emit(AuthenticationLoadingState(isLoading: false));
  //     }
  //   });

  //   on<SignOutEvent>((event, emit) async {
  //     emit(AuthenticationLoadingState(isLoading: true));
  //     try {
  //       authService.signOut();
  //       emit(AuthenticationFailureState('error'));
  //     } catch (e) {
  //       print(e.toString());
  //       emit(AuthenticationLoadingState(isLoading: false));
  //     }
  //   });
  // }
}
