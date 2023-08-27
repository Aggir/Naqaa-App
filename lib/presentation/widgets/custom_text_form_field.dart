import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';

import '../../app/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.maxLength,
    this.defaultValidator = true,
    this.enabled = true,
    this.readOnly = false,
    this.focusedStyleEnabled = true,
    this.initialValue,
    this.hintText,
    this.suffixIcon,
    this.isPassword = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.hideErrorMessage = false,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.customDecoration,
  });
  final TextInputType keyboardType;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final bool defaultValidator;
  final bool enabled;
  final bool readOnly;
  final bool focusedStyleEnabled;
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool hideErrorMessage;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final InputDecoration? customDecoration;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _visible = false;
  bool _showError = false;
  String _errorMessage = '';

  Widget _suffixIconContainer({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.small).r,
      child: child,
    );
  }

  Widget _visibilityIconButton(String svgPath) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.small / 2).r,
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _toggleVisible,
          child: Padding(
            padding: const EdgeInsets.all(AppValues.small / 2).r,
            child: SvgPicture.asset(svgPath),
          ),
        ),
      ),
    );
  }

  Widget get _passwordSuffixIconButton => _visible
      ? _visibilityIconButton(SvgAssets.invisible)
      : _visibilityIconButton(SvgAssets.visible);

  void _toggleVisible() {
    setState(() {
      _visible = !_visible;
    });
  }

  Widget? get _suffixIcon => widget.isPassword
      ? _passwordSuffixIconButton
      : widget.suffixIcon != null
          ? _suffixIconContainer(child: widget.suffixIcon!)
          : null;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      errorStyle: const TextStyle(height: 0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.smallRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.smallRadius.r),
        borderSide: const BorderSide(color: AppColors.pastelBlue),
      ),
      focusedBorder: widget.focusedStyleEnabled
          ? null
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.smallRadius.r),
              borderSide: const BorderSide(color: AppColors.pastelBlue),
            ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 0, horizontal: AppValues.medium)
              .r,
      fillColor: widget.enabled
          ? AppColors.snowWhite
          : AppColors.snowWhite.withOpacity(0.20),
      filled: true,
      counterText: '',
      suffixIcon: _suffixIcon,
      hintText: widget.hintText ?? '',
      hintStyle: textFieldHintStyle(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppValues.textFieldHeight.r,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            obscureText: widget.isPassword ? !_visible : false,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            initialValue: widget.initialValue,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            style: widget.enabled ? regularBlackStyle() : textFieldHintStyle(),
            inputFormatters: getFormatters(),
            validator: (value) => (widget.defaultValidator
                ? _defaultValidator(value, widget.validator)
                : null),
            decoration: widget.customDecoration ?? inputDecoration,
          ),
        ),
        if (_showError)
          Padding(
            padding: const EdgeInsets.only(top: AppValues.extraSmall).r,
            child: Text(
              _errorMessage,
              style: regularRedExtraSmallStyle(),
            ),
          )
      ],
    );
  }

  String? _defaultValidator(
      String? value, String? Function(String? value)? validator) {
    // check if there is a custom Validator
    if (validator != null) {
      String? errorMessage = validator(value);
      if (errorMessage != null) {
        if (!widget.hideErrorMessage) {
          setState(() {
            _showError = true;
            _errorMessage = errorMessage;
          });
        }
        return '';
      } else {
        if (!widget.hideErrorMessage) {
          setState(() {
            _showError = false;
            _errorMessage = '';
          });
        }
        return null;
      }
    } else {
      // use the default validator
      if (value == null || value.isEmpty) {
        if (!widget.hideErrorMessage) {
          setState(() {
            _showError = true;
            _errorMessage = AppStrings.thisFieldIsRequired.tr();
          });
        }
        return '';
      } else {
        if (!widget.hideErrorMessage) {
          setState(() {
            _showError = false;
            _errorMessage = '';
          });
        }
        return null;
      }
    }
  }

  List<TextInputFormatter> getFormatters() {
    switch (widget.keyboardType) {
      case TextInputType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case TextInputType.phone:
        return [FilteringTextInputFormatter.allow(RegExp(r'^\+?\d+'))];
      case TextInputType.name:
        return [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Zأ-ي]+| +|\s'))
        ];
      default:
        return [];
    }
  }
}
