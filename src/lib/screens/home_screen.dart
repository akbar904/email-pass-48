
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/home_cubit.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
				actions: [
					IconButton(
						icon: Icon(Icons.logout),
						onPressed: () {
							context.read<HomeCubit>().logout();
						},
					),
				],
			),
			body: Center(
				child: ElevatedButton(
					onPressed: () {
						context.read<HomeCubit>().logout();
					},
					child: Text('Logout'),
				),
			),
		);
	}
}
