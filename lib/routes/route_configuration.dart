import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proj4_flutter/routes/route_utils.dart';
import 'package:proj4_flutter/screen/error.dart';
import 'package:proj4_flutter/screen/login.dart';
import 'package:proj4_flutter/screen/splash.dart';
import 'package:proj4_flutter/screen/teams_screen.dart';
import 'package:proj4_flutter/services/app_service.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: APP_PAGE.userTeams.toPath,
    // debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: APP_PAGE.splash.toName,
        path: APP_PAGE.splash.toPath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: APP_PAGE.login.toName,
        path: APP_PAGE.login.toPath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: APP_PAGE.userTeams.toName,
        path: APP_PAGE.userTeams.toPath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: TeamsScreen());
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: ErrorScreen(
          error: state.error.toString(),
        ),
      );
    },
    redirect: (context, state) {
      final splashLocation = state.namedLocation(APP_PAGE.splash.toName);
      final loginLocation = state.namedLocation(APP_PAGE.login.toName);
      final teamsLocation = state.namedLocation(APP_PAGE.userTeams.toName);

      final isLogedIn = appService.loginState;
      final isInitialized = appService.initialized;

      final isGoingToLogin = state.matchedLocation == loginLocation;
      final isGoingToInit = state.matchedLocation == splashLocation;

      if (!isInitialized && !isGoingToInit) {
        return splashLocation;
      } else if (isInitialized && !isLogedIn && !isGoingToLogin) {
        return loginLocation;
      } else if ((isLogedIn && isGoingToLogin) || (isInitialized && isGoingToInit)) {
        return teamsLocation;
      } else {
        return null;
      }
    },
  );
}
