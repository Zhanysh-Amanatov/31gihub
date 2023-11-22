part of 'auth_bloc.dart';

// @immutable
abstract class AuthState extends Equatable {
  const AuthState([List props = const []]);
}

class InitialAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthState {
  final String? displayName;
  const AuthenticationSuccess({this.displayName});

  @override
  List<Object?> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends AuthState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [];
}
