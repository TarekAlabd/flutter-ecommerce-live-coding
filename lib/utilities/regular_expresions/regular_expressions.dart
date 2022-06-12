class RegularExpressions {
  static const String passwordRgx =
      '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}';
}
