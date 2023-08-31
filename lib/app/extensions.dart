import 'package:easy_localization/easy_localization.dart';

extension Validators on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  DateTime? get asNullableDate =>
      isNotEmpty ? DateFormat('dd/MM/yyyy').parse(this) : null;
}

extension Formatter on double {
  String asString() {
    if (this == toInt()) {
      return toInt().toString();
    } else {
      return toString();
    }
  }
}
