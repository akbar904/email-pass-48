
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/login_cubit.dart';

class LoginForm extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final loginCubit = context.read<LoginCubit>();

		final _emailController = TextEditingController();
		final _passwordController = TextEditingController();

		return BlocListener<LoginCubit, LoginState>(
			listener: (context, state) {
				if (state is LoginFailure) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(content: Text(state.errorMessage)),
					);
				}
			},
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Form(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							TextFormField(
								key: Key('emailField'),
								controller: _emailController,
								decoration: InputDecoration(labelText: 'Email'),
								keyboardType: TextInputType.emailAddress,
								validator: (value) {
									if (value == null || value.isEmpty) {
										return 'Please enter your email';
									}
									if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
										return 'Please enter a valid email address';
									}
									return null;
								},
							),
							TextFormField(
								key: Key('passwordField'),
								controller: _passwordController,
								decoration: InputDecoration(labelText: 'Password'),
								obscureText: true,
								validator: (value) {
									if (value == null || value.isEmpty) {
										return 'Please enter your password';
									}
									return null;
								},
							),
							SizedBox(height: 16.0),
							ElevatedButton(
								onPressed: () {
									final email = _emailController.text;
									final password = _passwordController.text;
									if (email.isNotEmpty && password.isNotEmpty) {
										loginCubit.login(email, password);
									}
								},
								child: Text('Login'),
							),
						],
					),
				),
			),
		);
	}
}
