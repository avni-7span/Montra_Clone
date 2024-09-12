import 'package:formz/formz.dart';

/// * We are validating the password TextField while login and
/// quote TextField while uploading quote to Firebase Firestore database with [formz](https://pub.dev/packages/formz).

enum EmptyFieldValidatorError { invalid }

class EmptyFieldValidator extends FormzInput<String, EmptyFieldValidatorError> {
  const EmptyFieldValidator.pure() : super.pure('');
  const EmptyFieldValidator.dirty([super.value = '']) : super.dirty();

  /// This validator checks if the TextField is empty or not.
  @override
  EmptyFieldValidatorError? validator(String? value) {
    if (value == null || value == '') {
      return EmptyFieldValidatorError.invalid;
    } else {
      return null;
    }
  }
}
