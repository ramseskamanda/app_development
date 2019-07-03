class Environment {
  //App wide settings
  static const String appName = 'Studentup';
  static const String slogan = 'Start-up your future';
  static const Duration splashScreenDuration = Duration(milliseconds: 2110);
  static const Duration flushbarDuration = Duration(milliseconds: 2110);
  //Hero Tags
  static const String logoHeroTag = 'app_logo_icon';
  //Local Storage keys
  static const String signedUpKey = 'signedUp';
  //Messages and misc.
  static const String fatalErrorMessage =
      'Unfortunately, a fatal error occured. We are investigating it but in the meantime, the app will restart in 30 seconds.';
  static const String failedRegistrationMessage =
      'The attempt at registering your account was unsuccesful. Please try again later.';
  static const String failedAuthenticationMessage =
      'The attempt to authenticate your account with our services was unsuccesful. Please try again later.';
  static const String failedLoginMessage =
      'Your login was unsuccesful. Please try again later.';
  //Default values for common variables
  static const String defaultPhotoUrl = 'default';
  static const String defaultBio = 'You biographical quote.';
  //Common errors and permission keys
  static const String permissionDeniedCamera = "PERMISSION_NOT_GRANTED";
}
