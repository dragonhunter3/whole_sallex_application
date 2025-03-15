import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';

class CustomTextFormField extends StatelessWidget {
  final int? maxline;
  final int? maxLength;
  final double? height;
  final double? hintSize;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final EdgeInsetsGeometry? contentPadding;
  final String? hint;
  final String? labelText;
  final String? initialValue;
  final bool? obscureText;
  final bool? filled;
  final bool? isCollapsed;
  final bool? isDense;
  final bool? isEnabled;
  final bool? readOnly;
  final Color? fillColor;
  final Color? hintColor;
  final Color? inputColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final InputDecoration? customDecoration;
  final String? semanticLabel;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;

  // New validation function
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.maxline,
    this.maxLength,
    this.height,
    this.hintSize,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.contentPadding,
    this.hint,
    this.labelText,
    this.initialValue,
    this.obscureText,
    this.filled = true,
    this.isCollapsed,
    this.isDense,
    this.isEnabled,
    this.readOnly,
    this.fillColor,
    this.hintColor,
    this.inputColor,
    this.borderColor,
    this.focusBorderColor,
    this.cursorColor,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.keyboardType,
    this.inputAction,
    this.autoValidateMode,
    this.textStyle,
    this.errorTextStyle,
    this.customDecoration,
    this.semanticLabel,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.controller,
    this.autofillHints,
    this.validator, // Accepts a validation function
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofillHints: autofillHints,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      cursorColor: cursorColor,
      maxLines: (obscureText ?? false) ? 1 : (maxline ?? 1),
      textInputAction: inputAction,
      initialValue: initialValue,
      style: textStyle ??
          txtTheme(context)
              .headlineMedium
              ?.copyWith(color: colorScheme(context).surface),
      autofocus: false,
      keyboardType: keyboardType,
      onChanged: onChanged,
      autovalidateMode: autoValidateMode,
      readOnly: readOnly ?? false,
      enabled: isEnabled ?? true,
      validator: validator, // Uses the provided validator
      decoration: customDecoration ??
          InputDecoration(
            labelText: labelText,
            labelStyle: txtTheme(context)
                .headlineMedium
                ?.copyWith(color: colorScheme(context).surface),
            counterText: '',
            hintText: hint,
            hintStyle: GoogleFonts.sora(
                color: hintColor ?? colorScheme(context).outline,
                fontSize: hintSize ?? 16),
            filled: filled ?? true,
            fillColor:
                fillColor ?? colorScheme(context).onSurface.withOpacity(0.05),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: horizontalPadding ?? 20.0,
                  vertical: verticalPadding ?? 12,
                ),
            errorStyle: errorTextStyle,
            errorMaxLines: 2,
            isCollapsed: isCollapsed ?? false,
            isDense: isDense,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ??
                    colorScheme(context).surface.withOpacity(0.1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusBorderColor ??
                    colorScheme(context).primary.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 2),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).primary,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).primary.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).primary.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 2),
            ),
          ),
      onFieldSubmitted: onFieldSubmitted,
      onTapOutside: onTapOutside ??
          (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
    );
  }
}
