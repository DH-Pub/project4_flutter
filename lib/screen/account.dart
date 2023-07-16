import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/colors_const.dart';
import 'package:proj4_flutter/controllers/user_controllers.dart';
import 'package:proj4_flutter/models/user.dart';
import 'package:proj4_flutter/shared/menu_bottom.dart';
import 'package:proj4_flutter/shared/menu_drawer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserController userController = UserController();
  User user = User('', '', '', '', '', '');

  @override
  void initState() {
    userController.getAccount().then((value) {
      if (value != null) {
        user = value;
        userController.emailController.text = value.email;
        userController.usernameController.text = value.username;
        userController.bioController.text = value.bio;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          title: const Text("Your Account"),
        ),
        drawer: const MenuDrawer(),
        bottomNavigationBar: const MenuBottom(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                enabled: false,
                controller: userController.emailController,
                decoration: const InputDecoration(
                  labelText: "Email address",
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: userController.usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            userController.updateAccount().then((value) {
              if (value != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Saved")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      userController.errMsg,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }
            });
            setState(() {});
          },
          backgroundColor: COLOR_CONST.green2,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
