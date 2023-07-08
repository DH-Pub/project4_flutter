// ignore: camel_case_types
enum APP_PAGE {
  splash,
  login,
  signup,
  error,
  userTeams,
  // after create or select team
  home,
  team,
}

extension AppPageExtension on APP_PAGE {
  static const Map<APP_PAGE, String> pathMap = {
    APP_PAGE.splash: "/splash",
    APP_PAGE.login: "/login",
    APP_PAGE.signup: "/signup",
    APP_PAGE.error: "/error",
    APP_PAGE.userTeams: "/user-teams",
    // after create/select team
    APP_PAGE.home: "/",
    APP_PAGE.team: "/team",
  };
  String get toPath {
    return pathMap[this] ?? '/';
  }

  static const Map<APP_PAGE, String> namePath = {
    APP_PAGE.splash: "SPLASH",
    APP_PAGE.login: "LOGIN",
    APP_PAGE.signup: "SIGNUP",
    APP_PAGE.error: "ERROR",
    APP_PAGE.userTeams: "USER_TEAMS",
    // after create/select team
    APP_PAGE.home: "HOME",
    APP_PAGE.team: "TEAM",
  };
  String get toName {
    return namePath[this] ?? '/';
  }

  static const Map<APP_PAGE, String> titlePath = {
    APP_PAGE.splash: "My App Splash",
    APP_PAGE.login: "Login",
    APP_PAGE.signup: "Signup",
    APP_PAGE.error: "Error",
    APP_PAGE.userTeams: "Your teams",
    // after create/select team
    APP_PAGE.home: "Home",
    APP_PAGE.team: "Team",
  };
  String get toTitle {
    return titlePath[this] ?? '/';
  }
}
