enum AppScreen {
  home,
  onboarding,
  signIn,
  signUp,
  forgotPassword,
  forgotPasswordInstructionsSent,
}

extension AppScreenExtension on AppScreen {
  String get toPath {
    switch (this) {
      case AppScreen.home:
        return "/";
      case AppScreen.onboarding:
        return "/start";
      case AppScreen.signIn:
        return "/sign-in";
      case AppScreen.signUp:
        return "/sign-up";
      case AppScreen.forgotPassword:
        return "/forgot-password";
      case AppScreen.forgotPasswordInstructionsSent:
        return "/forgot-password-instructions-sent";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppScreen.home:
        return "HOME";
      case AppScreen.onboarding:
        return "START";
      case AppScreen.signIn:
        return "SIGN-IN";
      case AppScreen.signUp:
        return "SIGN-UP";
      case AppScreen.forgotPassword:
        return "FORGOT PASSWORD";
      case AppScreen.forgotPasswordInstructionsSent:
        return "FORGOT PASSWORD INSTRUCTIONS SENT";
      default:
        return "HOME";
    }
  }
}
