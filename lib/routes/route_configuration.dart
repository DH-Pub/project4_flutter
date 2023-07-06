import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proj4_flutter/routes/route_utils.dart';
import 'package:proj4_flutter/screen/error.dart';
import 'package:proj4_flutter/screen/login.dart';
import 'package:proj4_flutter/screen/splash.dart';
import 'package:proj4_flutter/screen/teams.dart';
import 'package:proj4_flutter/services/app_service.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: AppPage.userTeams.toPath,
    // debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: AppPage.splash.toName,
        path: AppPage.splash.toPath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: AppPage.login.toName,
        path: AppPage.login.toPath,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: AppPage.userTeams.toName,
        path: AppPage.userTeams.toPath,
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
      final splashLocation = state.namedLocation(AppPage.splash.toName);
      final loginLocation = state.namedLocation(AppPage.login.toName);
      final teamsLocation = state.namedLocation(AppPage.userTeams.toName);

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
