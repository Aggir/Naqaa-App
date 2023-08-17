enum AppScreen {
  onboarding,
  signIn,
  signUp,
  forgotPassword,
  forgotPasswordInstructionsSent,
  home,
  statistics,
  notifications,
  settings,
  changePassword,
  editProfile,
  appSettings,
  termsOfUse,
  privacyPolicy,
  aboutUs,
  setupDeviceOnboarding,
  setupDeviceSelectNetwork,
}

extension AppScreenExtension on AppScreen {
  String get toPath {
    switch (this) {
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
      case AppScreen.home:
        return "/";
      case AppScreen.statistics:
        return "/statistics";
      case AppScreen.notifications:
        return "/notifications";
      case AppScreen.settings:
        return "/settings";
      case AppScreen.changePassword:
        return "/change-password";
      case AppScreen.editProfile:
        return "/edit-profile";
      case AppScreen.appSettings:
        return "/app-settings";
      case AppScreen.termsOfUse:
        return "/terms-of-use";
      case AppScreen.privacyPolicy:
        return "/privacy-policy";
      case AppScreen.aboutUs:
        return "/about-us";
      case AppScreen.setupDeviceOnboarding:
        return "/setup-device-onboarding";
      case AppScreen.setupDeviceSelectNetwork:
        return "/setup-device-select-network";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
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
      case AppScreen.home:
        return "HOME";
      case AppScreen.statistics:
        return "STATISTICS";
      case AppScreen.notifications:
        return "NOTIFICATIONS";
      case AppScreen.settings:
        return "SETTINGS";
      case AppScreen.changePassword:
        return "CHANGE PASSWORD";
      case AppScreen.editProfile:
        return "EDIT PROFILE";
      case AppScreen.appSettings:
        return "APP SETTINGS";
      case AppScreen.termsOfUse:
        return "TERMS OF USE";
      case AppScreen.privacyPolicy:
        return "PRIVACY POLICY";
      case AppScreen.aboutUs:
        return "ABOUT US";
      case AppScreen.setupDeviceOnboarding:
        return "SETUP DEVICE ONBOARDING";
      case AppScreen.setupDeviceSelectNetwork:
        return "SETUP DEVICE SELECT NETWORK";
      default:
        return "HOME";
    }
  }

  // String get asSubPath {
  //   switch (this) {
  //     case AppScreen.changePassword:
  //       return "change-password";
  //     default:
  //       return "";
  //   }
  // }
}
