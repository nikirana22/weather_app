class TextUtils {
  TextUtils._();

  static bool isEmpty(String? str) {
    return str != null && str.isEmpty;
  }

  static bool isNotEmpty(String? str) {
    return str != null && str.isNotEmpty;
  }

  static bool isValidEmail(String email) {
    final RegExp pattern = RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$');
    return email.isNotEmpty && pattern.hasMatch(email);
  }
}
