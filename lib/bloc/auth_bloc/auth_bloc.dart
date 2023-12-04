import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llapp/bloc/auth_bloc/auth_event.dart';
import 'package:llapp/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc(super.initialState);

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInEvent) {
      yield AuthLoadingState();

      try {
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        yield AuthAuthenticatedState(user: userCredential.user!);
      } catch (e) {
        yield AuthErrorState(errorMessage: e.toString());
      }
    } else if (event is RegisterEvent) {
      yield AuthLoadingState();

      try {
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        yield AuthAuthenticatedState(user: userCredential.user!);
      } catch (e) {
        yield AuthErrorState(errorMessage: e.toString());
      }
    } else if (event is SignOutEvent) {
      yield AuthLoadingState();

      try {
        await _firebaseAuth.signOut();
        yield AuthSignedOutState();
      } catch (e) {
        yield AuthErrorState(errorMessage: e.toString());
      }
    }
  }
}
