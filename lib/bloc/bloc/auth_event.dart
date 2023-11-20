part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SingUpRequested extends AuthEvent {
  final String email;
  final String password;

  SingUpRequested(this.email, this.password);
}
