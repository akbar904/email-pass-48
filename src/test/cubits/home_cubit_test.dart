
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';

class MockHomeCubit extends MockCubit<void> implements HomeCubit {}

void main() {
	group('HomeCubit', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = MockHomeCubit();
		});

		tearDown(() {
			homeCubit.close();
		});

		blocTest<HomeCubit, void>(
			'emits nothing when initialized',
			build: () => homeCubit,
			expect: () => [],
		);

		blocTest<HomeCubit, void>(
			'calls logout method',
			build: () => homeCubit,
			act: (cubit) => cubit.logout(),
			verify: (_) {
				verify(() => homeCubit.logout()).called(1);
			},
		);
	});
}
