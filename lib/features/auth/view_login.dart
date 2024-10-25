import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username')),
            const SizedBox(height: 10),
            TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: authViewModel.isLoading
                  ? () {}
                  : () async {
                      final navigator = Navigator.of(context);
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      bool success = await authViewModel.login(
                        _usernameController.text,
                        _passwordController.text,
                      );
                      if (success) {
                        navigator.pushReplacementNamed('/home');
                      } else {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(content: Text('Login failed')),
                        );
                      }
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login'),
                  if (authViewModel.isLoading)
                    const SizedBox(
                        width: 15), // Adds spacing between text and loader
                  if (authViewModel.isLoading)
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
