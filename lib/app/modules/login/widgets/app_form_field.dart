import 'package:flutter/material.dart';
import 'package:raxii/app/theme/app_colors.dart';
import 'package:raxii/app/shared/size.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? initialValue;
  final bool readOnly;

  const AppTextField(
      {Key? key,
      this.readOnly = false,
      required this.label,
      required this.hintText,
      this.obscureText = false,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.initialValue,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: AppFontSize.medium,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppSpaceSize.tiny),
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          obscureText: obscureText,
          style: TextStyle(color: AppColors.secondary),
          onChanged: onChanged,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.steelGray.withOpacity(0.7),
            ),
            filled: true,
            fillColor: AppColors.softGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpaceSize.tiny),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon,
            suffix: suffix,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
