part of 'auth_bloc.dart';

// @immutable
abstract class AuthState extends Equatable {
  const AuthState([List props = const []]);
}

class Unitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final String displayName;

  Authenticated(this.displayName) : super([displayName]);

  @override
  String toString() => 'Authenticated { displayName: $displayName }';

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object?> get props => [];
}
