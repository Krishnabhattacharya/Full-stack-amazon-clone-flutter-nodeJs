import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.label,
    required this.context,
    // this.border,
    this.validator,
    this.keyboardType,
    this.enabled,
    this.textStyle,
    this.onChanged,
    this.onTapOutside,
    this.onTap,
    this.hintText,
    this.hintTextStyle,
    this.inputFormatters,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 255,
    this.obscureText = false,
    this.readOnly = false,
    this.alignLabelWithHint = true,
    this.addEmailValidation = false,
    this.borderRadius = 20.0,
    this.contentPadding = 12.0,
    this.counterText = "",
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String? counterText;
  final BuildContext context;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? Function(String? value)? validator;
  final Function(String)? onChanged;
  final Function(PointerDownEvent)? onTapOutside;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? obscureText;
  final bool? addEmailValidation;
  final bool? alignLabelWithHint;
  final bool? readOnly;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double? borderRadius;
  final double? contentPadding;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ?? _validateInput,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside ?? _unfocusOnTapOutside,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      enabled: enabled,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscureText!,
      readOnly: readOnly!,
      style: textStyle,
      decoration: _buildInputDecoration(),
    );
  }

  String? _validateInput(String? value) {
    if (value!.trim().length < 4 || value.trim().length > 255) {
      return 'It should be 4 to 255 characters long.';
    } else if (!isEmailValid(value.trim()) && addEmailValidation!) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _unfocusOnTapOutside(PointerDownEvent event) {
    FocusScope.of(context).unfocus();
  }

  InputDecoration _buildInputDecoration() {
    String? errorText = validator != null ? validator!(controller.text) : null;
    bool hasError = errorText != null && errorText.isNotEmpty;

    return InputDecoration(
      alignLabelWithHint: alignLabelWithHint,
      labelText: label,
      hintText: hintText,
      hintStyle: hintTextStyle,
      filled: true,
      counterText: counterText,
      contentPadding: EdgeInsets.all(contentPadding!),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
        borderSide: BorderSide(
            color: hasError
                ? Colors.red
                : const Color.fromARGB(255, 109, 109, 109)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
        borderSide: BorderSide(
            color: hasError
                ? Colors.red
                : const Color.fromARGB(255, 109, 109, 109)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
        borderSide: BorderSide(
            color: hasError
                ? Colors.red
                : const Color.fromARGB(255, 109, 109, 109)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  bool isEmailValid(String email) {
    return _emailRegex.hasMatch(email);
  }
}
