enum AppPage {
  splash,
  login,
  signup,
  error,
  userTeams,
  createTeam,
  team,
}

extension AppPageExtension on AppPage {
  static const Map<AppPage, String> pathMap = {
    AppPage.splash: "/splash",
    AppPage.login: "/login",
    AppPage.signup: "/signup",
    AppPage.error: "/error",
    AppPage.userTeams: "/user-teams",
    AppPage.createTeam: "/create-team",
    AppPage.team: "/team",
  };
  String get toPath {
    return pathMap[this] ?? '/';
  }

  static const Map<AppPage, String> namePath = {
    AppPage.splash: "SPLASH",
    AppPage.login: "LOGIN",
    AppPage.signup: "SIGNUP",
    AppPage.error: "ERROR",
    AppPage.userTeams: "USER_TEAMS",
    AppPage.createTeam: "CREATE_TEAM",
    AppPage.team: "TEAM",
  };
  String get toName {
    return namePath[this] ?? '/';
  }

  static const Map<AppPage, String> titlePath = {
    AppPage.splash: "My App Splash",
    AppPage.login: "Login",
    AppPage.signup: "Signup",
    AppPage.error: "Error",
    AppPage.userTeams: "Your teams",
    AppPage.createTeam: "Create a team",
    AppPage.team: "Team",
  };
  String get toTitle {
    return titlePath[this] ?? '/';
  }
}
