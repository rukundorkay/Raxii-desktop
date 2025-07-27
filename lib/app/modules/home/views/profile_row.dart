import 'package:flutter/material.dart';
import 'package:raxii/app/shared/size.dart';

class ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(width: AppSpaceSize.tiny),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.medium,
          ),
        ),
        SizedBox(width: AppSpaceSize.medium),
        Flexible(
          child: Text(
            style: TextStyle(
              fontSize: AppFontSize.medium,
            ),
            value,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
