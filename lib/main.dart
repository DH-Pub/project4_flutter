import 'package:flutter/material.dart';
import 'package:proj4_flutter/screen/login.dart';

var kColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 34, 197, 94),
  brightness: Brightness.dark,
  surface: const Color.fromARGB(255, 34, 197, 94),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskLog',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorSchema,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
    );
  }
}
