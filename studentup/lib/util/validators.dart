import 'package:email_validator/email_validator.dart';

class Validator {
  static String name(String name) {
    return name.isNotEmpty ? null : 'Name field is empty';
  }

  static String email(String email) {
    if (email.isEmpty)
      return 'Email address is empty';
    else if (!EmailValidator.validate(email))
      return 'Email address is not valid';
    return null;
  }

  static String password(String password) {
    if (password.isEmpty || password.length < 6)
      return 'Password must be at least 6 characters';
    return null;
  }
}
