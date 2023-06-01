import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';

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
  String? validatePasswordConfirmation(
      String password, String confirmedPassword) {
    String errorMessage = 'Password mismatch';
    //
    return password == confirmedPassword ? null : errorMessage;
  }

  // empty password validation
  String? validateEmptyPassword(String password) {
    String errorMessage = 'Password required!';
    //
    if (password.isEmpty) {
      return errorMessage;
    }
    //
    return null;
  }

  // add trip
  // title validation
  String? validateTitle(String title) {
    String errorMessage = 'Title required!';
    const String pattern = r'(^[a-zA-Z\d-@]{1}([\w\s-@]){1,22}$)';
    final RegExp regex = RegExp(pattern);
    //
    if (title.isEmpty) {
      return errorMessage;
    }
    //
    if (!regex.hasMatch(title)) {
      errorMessage = 'Only letters, numbers, spaces, @, - allowed';
      return errorMessage;
    }
    //
    return null;
  }

  // budget validation
  String? validateBudget(int? budget, String? value) {
    String errorMessage = 'Enter a valid budget!';
    const String pattern = r'(^[\d]+$)';
    final RegExp regex = RegExp(pattern);
    //
    if (budget != null && value != null) {
      if (budget <= 0) {
        return errorMessage;
      }
      //
      if (!regex.hasMatch(value)) {
        errorMessage = 'Only whole numbers allowed!';
        return errorMessage;
      }
    }
    //
    return null;
  }

  // destinations validation
  String? validateDestinations(List<DestinationModel> destinations) {
    String errorMessage = 'Enter at least one destination';
    //
    if (destinations.isEmpty) {
      return errorMessage;
    }
    //
    return null;
  }

  // dates validation
  String? validateDates(DateTimeRange? dates) {
    String errorMessage = 'Enter Start and End dates';
    //
    if (dates == null) {
      return errorMessage;
    }
    //
    return null;
  }

  // add notes
  // title validation
  String? validateNoteTitle(String title) {
    String errorMessage = 'Title required!';
    const String pattern = r'(^[a-zA-Z\d-@]{1}([\w\s-@]){1,20}$)';
    final RegExp regex = RegExp(pattern);
    //
    if (title.isEmpty) {
      return errorMessage;
    }
    //
    if (!regex.hasMatch(title)) {
      errorMessage = 'Only letters, numbers, spaces, @, - allowed';
      return errorMessage;
    }
    //
    return null;
  }

  // body validation
  String? validateNoteBody(String body) {
    String errorMessage = 'Empty note';
    //
    if (body.length == 1) {
      return errorMessage;
    }
    //
    return null;
  }

  //Image name
  String? validateImageName(String name) {
    String errorMessage =
        'Name should be alphanumeric (_, and wide spaces also allowed) and between 5 to 30 characters long';
    const String pattern = r'(^[a-zA-Z]{1}([\w\s]){2,29}$)';
    const String onlyNumbersPattern = r'(^[\d]+$)';
    final RegExp regex = RegExp(pattern);
    final RegExp onlyNumberRegex = RegExp(onlyNumbersPattern);
    //
    if (name.isEmpty) {
      errorMessage = 'Please enter a name!';
      return errorMessage;
    }
    //
    if (name.length < 3 || name.length > 30) {
      errorMessage = 'Name should be 3 to 30 characters long';
      return errorMessage;
    }
    //
    if (onlyNumberRegex.hasMatch(name)) {
      errorMessage = 'Name should start with a letter';
      return errorMessage;
    }
    //
    if (!regex.hasMatch(name)) {
      errorMessage = 'Only letters, numbers and wide spaces allowed';
      return errorMessage;
    }
    //
    return null;
  }

  //
  // budget validation
  String? validateNumber(String value) {
    String errorMessage = 'Enter a valid amount!';
    const String pattern = r'(^[1-9]+(\.[\d]+)?$)';
    final RegExp regex = RegExp(pattern);
    //
    if (!regex.hasMatch(value)) {
      return errorMessage;
    }
    //
    return null;
  }
}
