import 'package:flutter/material.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/shared/widget/detail_tile.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account',
            style: TextStyle(
              fontSize: AppFontSize.large,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailTile(
                      label: 'Name',
                      value:
                          "${AuthService.to.user.value?.firstName} ${AuthService.to.user.value?.lastName}"),
                  DetailTile(
                      label: 'Role',
                      value: AuthService.to.user.value!.role.name),
                  DetailTile(
                      label: 'Phone Number',
                      value: AuthService.to.user.value!.phoneNumber),
                  DetailTile(
                      label: 'Business',
                      value: AuthService.to.user.value!.businessFacility.name),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget buildMenuItem({
  required IconData icon,
  required String title,
  required bool isSelected,
  required void Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.softGray : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppSpaceSize.tiny,
        horizontal: AppSpaceSize.defaultS,
      ),
      margin: EdgeInsets.symmetric(
        vertical: AppSpaceSize.tiny,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
