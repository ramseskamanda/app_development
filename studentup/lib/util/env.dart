class Environment {
  //App wide strings
  static const String appName = 'studentup Alpha';
  //Hero Tags
  static const String logoHeroTag = 'app_logo_icon';
  //Local Storage keys
  static const String signedUpKey = 'signedUp';
  //Messages and misc.
  static const String fatalErrorMessage =
      'Unfortunately, a fatal error occured. We are investigating it but in the meantime, the app needs to restart.';
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
