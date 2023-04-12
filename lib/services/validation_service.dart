class ValidationService {
  // email validation
  String? validateEmail(String email) {
    String errorMessage = 'Please enter a valid email address!';
    const String pattern =
        r'(^[a-z\d]+([\.-]*[a-z\d]+){0,4}@[a-z\d]+(\.[a-z]{2,8}){1,4}$)';
    final RegExp regex = RegExp(pattern);
    //
    return regex.hasMatch(email) ? null : errorMessage;
  }

  // username validation
  String? validateUsername(String username) {
    String errorMessage =
        'Username should be alphanumeric (_, and wide spaces also allowed) and between 5 to 15 characters long';
    const String pattern = r'(^[a-zA-Z]{1}([\w\s]){4,14}$)';
    const String onlyNumbersPattern = r'(^[\d]+$)';
    final RegExp regex = RegExp(pattern);
    final RegExp onlyNumberRegex = RegExp(onlyNumbersPattern);
    //
    if (username.isEmpty) {
      errorMessage = 'Please enter a username!';
      return errorMessage;
    }
    //
    if (username.length < 5 || username.length > 15) {
      errorMessage = 'Username should be 5 to 15 characters long';
      return errorMessage;
    }
    //
    if (onlyNumberRegex.hasMatch(username)) {
      errorMessage = 'Username should start with a letter';
      return errorMessage;
    }
    //
    if (!regex.hasMatch(username)) {
      errorMessage = 'Only letters, numbers and wide spaces allowed';
      return errorMessage;
    }
    //
    return null;
  }

  // password validation
  String? validatePassword(String password) {
    String errorMessage = '';
    const String pattern = r'(^[\w@-]{8,20}$)';
    final RegExp regex = RegExp(pattern);
    //
    if (password.isEmpty) {
      errorMessage = 'Please enter a password!';
      return errorMessage;
    }
    //
    if (password.length < 8 || password.length > 20) {
      errorMessage = 'Password should be 8 to 20 characters long';
      return errorMessage;
    }
    //
    if (!regex.hasMatch(password)) {
      errorMessage = 'Only letters, numbers, @, - allowed';
      return errorMessage;
    }
    //
    return null;
  }

  // password confirmation validation
  // password validation
  String? validatePasswordConfirmation(
      String password, String confirmedPassword) {
    String errorMessage = 'Password mismatch';
    //
    return password == confirmedPassword ? null : errorMessage;
  }
}
