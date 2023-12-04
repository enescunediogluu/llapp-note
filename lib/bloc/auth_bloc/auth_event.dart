abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });
}

class RegisterEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  RegisterEvent({
    required this.fullName,
    required this.email,
    required this.password,
  });
}

class SignOutEvent extends AuthEvent {}