import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username')),
            const SizedBox(height: 10),
            TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email')),
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
                      bool success = await authViewModel.register(
                        _usernameController.text,
                        _passwordController.text,
                        _emailController.text,
                      );
                      if (success) {
                        navigator.pop();
                      } else {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(content: Text('Registration failed')),
                        );
                      }
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Register'),
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
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text("Already have an account? Go to Login"),
            ),
          ],
        ),
      ),
    );
  }
}
