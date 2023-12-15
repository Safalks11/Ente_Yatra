class FormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter the name!!";
    }
    return null;
  }

  static String? simpleEmailValidator(String? value) {
    // Simple check for the presence of '@' in the email
    return value != null && value.contains('@gmail.com')
        ? null
        : 'Please enter a valid email!';
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return "Please enter a valid password!!";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return "Please re-enter your password!!";
    } else if (value != originalPassword) {
      return "Confirm password must be same as the entered password!!";
    }
    return null;
  }
}
