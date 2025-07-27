import 'package:flutter/material.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppFontSize.large,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.close,
            color: AppColors.alertRed,
            size: 30,
          ),
        )
      ],
    );
  }
}