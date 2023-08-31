import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_text_form_field.dart';

class CustomFormFieldDatePicker extends StatelessWidget {
  const CustomFormFieldDatePicker({
    super.key,
    this.validator,
    this.controller,
    this.defaultValidator = true,
    this.enabled = true,
    this.readOnly = true,
    this.initialValue,
    this.hintText,
    this.suffixIcon,
    this.showCalendarSuffixIcon = true,
    this.focusedStyleEnabled = false,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
  });
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final bool defaultValidator;
  final bool enabled;
  final bool readOnly;
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;
  final bool showCalendarSuffixIcon;
  final bool focusedStyleEnabled;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(String?)? onChanged;

  _showDatePicker(BuildContext context) async {
    DateTime getInitialDate() {
      if (initialDate == null) {
        if (controller != null && controller!.text.isNotEmpty) {
          return DateFormat('dd/MM/yyyy').parse(controller!.text);
        } else {
          return DateTime.now();
        }
      }
      return initialDate!;
    }

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: getInitialDate(),
        firstDate: firstDate ?? DateTime(1900),
        lastDate: lastDate ?? DateTime.now());
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      controller?.text = formattedDate;
      if (onChanged != null) {
        onChanged!(formattedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      defaultValidator: defaultValidator,
      enabled: enabled,
      readOnly: readOnly,
      initialValue: initialValue,
      hintText: hintText,
      focusedStyleEnabled: focusedStyleEnabled,
      onTap: () => _showDatePicker(context),
    );
  }
}
