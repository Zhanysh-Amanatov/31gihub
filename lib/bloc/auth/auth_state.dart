part of 'auth_bloc.dart';

// @immutable
abstract class AuthState extends Equatable {
  const AuthState([List props = const []]);
}

class InitialAuthState extends AuthState {
  // @override
  // String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends AuthState {
  // final String displayName;

  // Authenticated(this.displayName) : super([displayName]);

  // @override
  // String toString() => 'Authenticated { displayName: $displayName }';

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
