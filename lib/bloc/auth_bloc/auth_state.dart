import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState({required this.errorMessage});
}

class AuthAuthenticatedState extends AuthState {
  final User user;

  AuthAuthenticatedState({required this.user});
}

class AuthSignedOutState extends AuthState {}
