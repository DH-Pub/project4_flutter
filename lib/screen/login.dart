import 'package:flutter/material.dart';
import 'package:proj4_flutter/shared/gradient_scaffold.dart';
import 'package:proj4_flutter/widgets/user/login_form.dart';
import 'package:proj4_flutter/widgets/user/signup_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginForm = true;
  Widget mainContent = const CircularProgressIndicator();

  void changeForm() {
    isLoginForm = !isLoginForm;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GradientScaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(40),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(184, 184, 184, 184),
                      blurRadius: 3.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    isLoginForm
                        ? const LoginForm()
                        : SignupForm(
                            changeForm: changeForm,
                          ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLoginForm = !isLoginForm;
                        });
                      },
                      child: isLoginForm
                          ? const Text("Don't have an account? Sign up")
                          : const Text("Already have an account? Login"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
