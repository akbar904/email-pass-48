
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the states for the LoginCubit
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
	final String error;
	LoginFailure(this.error);
}

// Define the LoginCubit
class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		try {
			emit(LoginLoading());

			// Simulate network delay
			await Future.delayed(Duration(seconds: 2));

			// Simulate login logic
			if (email == 'email@example.com' && password == 'password123') {
				emit(LoginSuccess());
			} else {
				emit(LoginFailure('Invalid credentials'));
			}
		} catch (e) {
			emit(LoginFailure('An error occurred'));
		}
	}
}
