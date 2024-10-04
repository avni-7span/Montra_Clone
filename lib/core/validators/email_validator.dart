import 'package:formz/formz.dart';

/// * We are validating the email TextField with [formz](https://pub.dev/packages/formz).
enum EmailValidationError { invalid, empty }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();
  static final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// This validator method checks for, if TextField is empty and if it matches with emailRegExp.
  @override
  EmailValidationError? validator(String? value) {
    if (value == null || value == '') {
      return EmailValidationError.empty;
    } else if (!emailRegExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    } else {
      return null;
    }
  }
}
