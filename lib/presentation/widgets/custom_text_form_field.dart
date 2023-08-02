import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.initialValue,
    this.hintText,
    this.suffixIcon,
    this.isPassword = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.focusNode,
  });
  final TextInputType keyboardType;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final bool defaultValidator;
  final bool enabled;
  final bool readOnly;
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _visible = false;

  Widget _suffixIconContainer({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.small),
      child: child,
    );
  }

  Widget _visibilityIconButton(String svgPath) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.small / 2),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _toggleVisible,
          child: Padding(
            padding: const EdgeInsets.all(AppValues.small / 2),
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
      errorMaxLines: 3,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.textFieldRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.textFieldRadius),
        borderSide: BorderSide(color: AppColors.pastelBlue),
      ),
      contentPadding: const EdgeInsets.symmetric(
          vertical: AppValues.medium, horizontal: AppValues.medium),
      fillColor: AppColors.snowWhite,
      filled: true,
      counterText: '',
      suffixIcon: _suffixIcon,
      hintText: widget.hintText ?? '',
      hintStyle: textFieldHintStyle(),
    );

    return TextFormField(
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
      inputFormatters: getFormatters(),
      validator: widget.validator ??
          (widget.defaultValidator ? _defaultValidator : null),
      decoration: inputDecoration,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldIsRequired.tr();
    } else {
      return null;
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
