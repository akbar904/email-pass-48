
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should display logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<HomeCubit>(
						create: (context) => MockHomeCubit(),
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});
	});

	group('HomeCubit Tests', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = MockHomeCubit();
		});

		blocTest<HomeCubit, HomeState>(
			'emits [] when nothing is added',
			build: () => homeCubit,
			expect: () => [],
		);

		blocTest<HomeCubit, HomeState>(
			'emits [HomeInitial] when logout is called',
			build: () => homeCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [HomeInitial()],
		);
	});
}
