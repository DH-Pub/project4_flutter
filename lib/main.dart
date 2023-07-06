import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proj4_flutter/routes/route_configuration.dart';
import 'package:proj4_flutter/services/app_service.dart';
import 'package:proj4_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var kColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 255, 255, 255),
  brightness: Brightness.light,
  surface: const Color.fromARGB(255, 34, 197, 94),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({super.key, required this.sharedPreferences});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppService appService;
  late AuthService authService;
  late StreamSubscription<bool> authSubscription;

  void onAuthStateChagne(bool login) {
    appService.loginState = login;
  }

  @override
  void initState() {
    appService = AppService(widget.sharedPreferences);
    authService = AuthService();
    authSubscription = authService.onAuthStateChange.listen(onAuthStateChagne);
    super.initState();
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppService>(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter(appService)),
        Provider<AuthService>(create: (_) => authService),
      ],
      child: Builder(builder: (context) {
        final GoRouter goRouter = Provider.of<AppRouter>(context, listen: false).router;
        return MaterialApp.router(
          title: 'TaskLog',
          theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorSchema,
            scaffoldBackgroundColor: Colors.white,
          ),
          routerConfig: goRouter,
          // debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
