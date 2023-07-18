import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/user_controllers.dart';

class ChangePasswordAlert extends StatefulWidget {
  const ChangePasswordAlert({super.key});

  @override
  State<ChangePasswordAlert> createState() => _ChangePasswordAlertState();
}

class _ChangePasswordAlertState extends State<ChangePasswordAlert> {
  UserController userController = UserController();
  TextEditingController oldPassword = TextEditingController();
  bool oldPasswordObscure = true;
  bool passwordObscure = true;
  bool confirmObscure = true;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AlertDialog(
        title: Center(
          child: Column(
            children: [
              const Text("Change password"),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: oldPasswordObscure,
                controller: oldPassword,
                decoration: InputDecoration(
                  hintText: "Old Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        oldPasswordObscure = !oldPasswordObscure;
                      });
                    },
                    icon: Icon(oldPasswordObscure ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: passwordObscure,
                controller: userController.passwordController,
                decoration: InputDecoration(
                  hintText: "New Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordObscure = !passwordObscure;
                      });
                    },
                    icon: Icon(passwordObscure ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: confirmObscure,
                controller: userController.confirmPasswordController,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        confirmObscure = !confirmObscure;
                      });
                    },
                    icon: Icon(confirmObscure ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                userController.errMsg ?? "",
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.all(8),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              userController.changePassword(oldPassword.text).then((value) {
                if (value == true) {
                  Navigator.pop(context);
                }
                setState(() {});
              });
            },
            child: const Text(
              "Change",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
