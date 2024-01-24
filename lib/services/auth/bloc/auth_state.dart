part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateSignedUp extends AuthState {
  final AuthUser user;
  const AuthStateSignedUp(this.user);
}

class AuthStateSignedUpFailure extends AuthState {
  final Exception exception;
  const AuthStateSignedUpFailure(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateLoggedInFailure extends AuthState {
  final Exception exception;
  const AuthStateLoggedInFailure(this.exception);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLogOut extends AuthState {
  const AuthStateLogOut();
}

class AuthStateLogOutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogOutFailure(this.exception);
}
