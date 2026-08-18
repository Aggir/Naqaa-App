import 'package:easy_localization/easy_localization.dart';
import 'package:naqaa/app/extensions.dart';

import 'app_strings.dart';

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.thisFieldIsRequired.tr();
  } else if (!value.isValidEmail()) {
    return AppStrings.invalidEmail.tr();
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.thisFieldIsRequired.tr();
  } else if (value.length > 24) {
    return AppStrings.longPassword.tr();
  } else if (value.length < 8) {
    return AppStrings.shortPassword.tr();
  } else {
    return null;
  }
}

String? passwordMatchesTheConfirmationValidator(
    String? passwordValue, String confirmPasswordValue) {
  if (passwordValue == null || passwordValue.isEmpty) {
    return AppStrings.thisFieldIsRequired.tr();
  } else if (passwordValue.length > 24) {
    return AppStrings.longPassword.tr();
  } else if (passwordValue.length < 8) {
    return AppStrings.shortPassword.tr();
  } else if (passwordValue != confirmPasswordValue) {
    return ' ';
  } else {
    return null;
  }
}

String? confirmPasswordMatchesPasswordValidator(
    String? confirmPasswordValue, String passwordValue) {
  if (confirmPasswordValue == null || confirmPasswordValue.isEmpty) {
    return AppStrings.thisFieldIsRequired.tr();
  } else if (confirmPasswordValue != passwordValue) {
    return AppStrings.confirmPasswordValidation.tr();
  } else {
    return null;
  }
}
