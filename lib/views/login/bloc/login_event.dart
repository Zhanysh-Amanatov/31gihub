class LoginButtonPressedEvent extends LoginEvent {
  LoginButtonPressedEvent();
}

class LoginEmailChangedEvent extends LoginEvent {
  LoginEmailChangedEvent({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}

class LoginPasswordChangedEvent extends LoginEvent {
  LoginPasswordChangedEvent({required this.password});
  final String password;
  @override
  List<Object> get props => [password];
}

class LoginEvent {}
