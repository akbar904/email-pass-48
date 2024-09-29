
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_package_name/screens/login_screen.dart';

// Mock classes and other necessary setups
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		testWidgets('renders LoginForm', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: loginCubit,
						child: LoginScreen(),
					),
				),
			);

			expect(find.byType(LoginForm), findsOneWidget);
		});

		testWidgets('contains email and password text fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: loginCubit,
						child: LoginScreen(),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2));
		});

		testWidgets('contains login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: loginCubit,
						child: LoginScreen(),
					),
				),
			);

			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('calls login on login button press', (WidgetTester tester) async {
			when(() => loginCubit.login(any(), any())).thenAnswer((_) async {});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: loginCubit,
						child: LoginScreen(),
					),
				),
			);

			await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
			await tester.enterText(find.byKey(Key('passwordField')), 'password');

			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => loginCubit.login('test@example.com', 'password')).called(1);
		});
	});
}
