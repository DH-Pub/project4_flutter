import 'package:flutter/material.dart';
import 'package:proj4_flutter/models/user.dart';
import 'package:proj4_flutter/shared/menu_bottom.dart';
import 'package:proj4_flutter/shared/menu_drawer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User user = User('', '', '', '', '', '');

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
      ),
    );
  }
}
