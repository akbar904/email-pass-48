
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/main.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}
class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('App initializes with MyApp', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(MyApp), findsOneWidget);
		});

		testWidgets('Displays LoginScreen at startup', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('Cubits Initialization', () {
		testWidgets('LoginCubit is provided', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			final loginCubit = BlocProvider.of<LoginCubit>(tester.element(find.byType(MyApp)));
			expect(loginCubit, isNotNull);
		});

		testWidgets('HomeCubit is provided', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			final homeCubit = BlocProvider.of<HomeCubit>(tester.element(find.byType(MyApp)));
			expect(homeCubit, isNotNull);
		});
	});
}
