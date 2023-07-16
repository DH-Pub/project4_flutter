import 'package:flutter/material.dart';
import 'package:proj4_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool passwordVisible;

  @override
  void initState() {
    passwordVisible = true;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: 'Email address',
            // focusedBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: passwordVisible,
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Error Message
        Text(
          authService.errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
        ElevatedButton(
          onPressed: () {
            // FocusManager.instance.primaryFocus?.unfocus();
            authService.loginUser(emailController.text, passwordController.text).then((value) {
              setState(() {});
            });
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
