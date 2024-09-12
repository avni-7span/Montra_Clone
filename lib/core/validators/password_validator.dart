import 'package:formz/formz.dart';

/// * We are validating the password TextField with [formz](https://pub.dev/packages/formz).
enum PasswordValidationError { invalid, empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  static final passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  /// This validator method checks for, if TextField is empty and if it matches with passwordRegExp.
  @override
  PasswordValidationError? validator(String? value) {
    if (value == '' || value == null) {
      return PasswordValidationError.empty;
    } else {
      return passwordRegExp.hasMatch(value)
          ? null
          : PasswordValidationError.invalid;
    }
  }
}
