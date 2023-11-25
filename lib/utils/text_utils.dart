class TextUtils {
  TextUtils._();

  static String? validatePassword(String? str) {
    return str != null && str.isNotEmpty ? null : 'Please enter Password';
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    return password != confirmPassword ? 'Password didn\'t match' : null;
  }

  static String? validateEmail(String? email) {
    final RegExp pattern = RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$');
    return email != null && pattern.hasMatch(email)
        ? null
        : 'Please Enter Valid Email';
  }
}
