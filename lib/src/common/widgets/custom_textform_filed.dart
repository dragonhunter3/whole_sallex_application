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
      style: textStyle ?? txtTheme(context).bodyMedium,
      autofocus: false,
      keyboardType: keyboardType,
      onChanged: onChanged,
      autovalidateMode: autoValidateMode,
      readOnly: readOnly ?? false,
      enabled: isEnabled ?? true,
      decoration: customDecoration ??
          InputDecoration(
            labelText: labelText,
            counterText: '',
            hintText: hint,
            hintStyle: GoogleFonts.sora(
                color: hintColor ?? colorScheme(context).outline,
                fontSize: hintSize ?? 14),
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
                    colorScheme(context).onSurface.withOpacity(0.1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusBorderColor ?? colorScheme(context).primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
      onFieldSubmitted: onFieldSubmitted,
      onTapOutside: onTapOutside ??
          (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
    );
  }

//   String? _validateInput(String? value) {
//     switch (validationType) {
//       case ValidationType.email:
//         if (value == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//           return 'please_enter_a_valid_email_address'.tr();
//         }
//         break;
//       case ValidationType.password:
//         if (value == null || value.length < 8) {
//           return 'Password'.tr();
//         }
//         break;
//       case ValidationType.phoneNumber:
//         if (value == null || !RegExp(r'^\d{10,11}$').hasMatch(value)) {
//           return 'please_enter_a_valid_phone_number'.tr();
//         }
//         break;
//       case ValidationType.username:
//         if (value == null || value.isEmpty) {
//           return 'Username_is_required'.tr();
//         }
//         if (value.length < 3 || !RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
//           return 'validate'.tr();
//         }
//         break;
//       case ValidationType.bio:
//         if (value == null || value.length < 10) {
//           return 'bio'.tr();
//         }
//         break;
//       case ValidationType.name:
//         if (value == null || !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
//           return 'vname'.tr();
//         }
//         break;
//       case ValidationType.url:
//         if (value == null ||
//             !RegExp(r'^(https?|ftp)://[^\s/$.?#].[^\s]*$').hasMatch(value)) {
//           return 'url'.tr();
//         }
//         break;
//       case ValidationType.number:
//         if (value == null || !RegExp(r'^\d+$').hasMatch(value)) {
//           return 'vnmumber'.tr();
//         }
//         break;
//       case ValidationType.age:
//         int? age = int.tryParse(value ?? '');
//         if (age == null || age < 10 || age > 100) {
//           return 'vage'.tr();
//         }
//         break;
//       case ValidationType.dateOfBirth:
//         if (value == null || !RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
//           return 'vbirth'.tr();
//         }
//         break;
//       case ValidationType.about:
//         if (value == null || value.length < 10) {
//           return 'morinfo'.tr();
//         }
//         break;
//       case ValidationType.playerNumber:
//         int? playerNumber = int.tryParse(value ?? '');
//         if (playerNumber == null || playerNumber < 1 || playerNumber > 99) {
//           return 'playernum'.tr();
//         }
//         break;
//       case ValidationType.height:
//         double? height = double.tryParse(value ?? '');
//         if (height == null || height < 50 || height > 250) {
//           return 'height'.tr();
//         }
//         break;
//       case ValidationType.weight:
//         double? weight = double.tryParse(value ?? '');
//         if (weight == null || weight < 30 || weight > 200) {
//           return 'weight'.tr();
//         }
//         break;
//       case ValidationType.jerseySize:
//         if (value == null || !RegExp(r'^(S|M|L|XL|XXL)$').hasMatch(value)) {
//           return 'size'.tr();
//         }
//         break;
//       case ValidationType.position:
//         List<String> validPositions = [
//           'Forward',
//           'Midfielder',
//           'Defender',
//           'Goalkeeper'
//         ];
//         if (value == null || !validPositions.contains(value)) {
//           return 'position'.tr();
//         }
//         break;
//       case ValidationType.teamName:
//         if (value == null || value.length < 3) {
//           return 'teamn'.tr();
//         }
//         break;
//       case ValidationType.playerClub:
//         if (value == null || value.isEmpty) {
//           return 'club'.tr();
//         }
//         break;
//       case ValidationType.playerCenter:
//         if (value == null || value.isEmpty) {
//           return 'center'.tr();
//         }
//         break;
//       case ValidationType.playerScout:
//         if (value == null || value.isEmpty) {
//           return 'scout'.tr();
//         }
//         break;
//       case ValidationType.address:
//         if (value == null || value.length < 5) {
//           return 'address'.tr();
//         }
//         break;
//       case ValidationType.playerGrade:
//         if (value == null || !RegExp(r'^[A-F]$').hasMatch(value)) {
//           return 'grade'.tr();
//         }
//         break;
//       case ValidationType.scoutGrade:
//         if (value == null || !RegExp(r'^[A-F]$').hasMatch(value)) {
//           return 'sgrade'.tr();
//         }
//         break;
//       case ValidationType.scoutClub:
//         if (value == null || value.isEmpty) {
//           return 'sclub'.tr();
//         }
//         if (value.length < 3) {
//           return 'sname'.tr();
//         }
//         break;
//       case ValidationType.report:
//         if (value == null || value.length < 10) {
//           return 'report'.tr();
//         }
//         break;
//       case ValidationType.empty:
//         if (value == null || value.isEmpty) {
//           return 'frequird'.tr();
//         }
//         break;
//       default:
//         return null;
//     }
//     return null;
//   }

//   List<TextInputFormatter> _getInputFormatters() {
//     return <TextInputFormatter>[];
//   }

//   TextTheme txtTheme(BuildContext context) {
//     return Theme.of(context).textTheme;
//   }

//   ColorScheme colorScheme(BuildContext context) {
//     return Theme.of(context).colorScheme;
//   }
// }

// enum ValidationType {
//   none,
//   email,
//   password,
//   phoneNumber,
//   cnic,
//   name,
//   url,
//   number,
//   age,
//   dateOfBirth,
//   about,
//   bio,
//   username,
//   playerNumber,
//   height,
//   weight,
//   jerseySize,
//   position,
//   teamName,
//   playerClub,
//   playerCenter,
//   playerScout,
//   address,
//   playerGrade,
//   scoutGrade,
//   scoutClub,
//   report,
//   empty,
// }
}
