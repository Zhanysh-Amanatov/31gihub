/*Local dependencies*/
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState([List props = const []]);
}

class InitialAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthernticationSuccessState extends AuthState {
  final String? displayName;
  const AuthernticationSuccessState({this.displayName});

  @override
  List<Object?> get props => [];
}

class ForgotPasswordState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends AuthState {
  final String error;
  const ErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
