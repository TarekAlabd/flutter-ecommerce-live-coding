class FormValidator{
  static bool isValidEmail(String input){
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(input);
  }
}