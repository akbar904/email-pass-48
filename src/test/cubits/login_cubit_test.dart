
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_cubit.dart';

// Mock class for LoginCubit
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginCubit', () {
		late MockLoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		test('initial state is LoginInitial', () {
			expect(loginCubit.state, equals(LoginInitial()));
		});

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) => cubit.login('email@example.com', 'password123'),
			expect: () => [LoginLoading(), LoginSuccess()],
			verify: (_) {
				verify(() => loginCubit.login('email@example.com', 'password123')).called(1);
			},
		);

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => loginCubit,
			act: (cubit) => cubit.login('email@example.com', 'wrongpassword'),
			expect: () => [LoginLoading(), LoginFailure('Invalid credentials')],
			verify: (_) {
				verify(() => loginCubit.login('email@example.com', 'wrongpassword')).called(1);
			},
		);
	});
}
