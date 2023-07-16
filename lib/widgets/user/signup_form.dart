import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/user_controllers.dart';

class SignupForm extends StatefulWidget {
  final Function changeForm;
  const SignupForm({super.key, required this.changeForm});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  UserController userController = UserController();
  late bool passwordVisible;
  late bool confirmVisible;

  @override
  void initState() {
    passwordVisible = true;
    confirmVisible = true;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: userController.emailController,
          decoration: const InputDecoration(
            hintText: "Email address",
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: userController.usernameController,
          decoration: const InputDecoration(
            hintText: "Username",
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: passwordVisible,
          controller: userController.passwordController,
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
        TextFormField(
          obscureText: confirmVisible,
          controller: userController.confirmPasswordController,
          decoration: InputDecoration(
            hintText: "Password",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  confirmVisible = !confirmVisible;
                });
              },
              icon: Icon(confirmVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          maxLines: null,
          controller: userController.bioController,
          decoration: const InputDecoration(
            labelText: "About yourself",
          ),
        ),
        const SizedBox(height: 20),
        Text(
          userController.errMsg,
          style: const TextStyle(color: Colors.red),
        ),
        ElevatedButton(
          onPressed: () {
            userController.signup().then((value) {
              if (value != null) {
                widget.changeForm();
              }
              setState(() {});
            });
          },
          child: const Text(
            "Create Team",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
