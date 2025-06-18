import 'package:flutter/material.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/shared/size.dart';
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
                  _buildDetail('Name',
                      "${AuthService.to.user.value?.firstName} ${AuthService.to.user.value?.lastName}"),
                  _buildDetail('Role', AuthService.to.user.value!.role.name),
                  _buildDetail(
                      'Phone Number', AuthService.to.user.value!.phoneNumber),
                  _buildDetail('Business',
                      AuthService.to.user.value!.businessFacility.name),
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

Widget _buildDetail(String label, String value) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    padding: EdgeInsets.symmetric(
      vertical: AppSpaceSize.tiny,
      horizontal: AppSpaceSize.defaultS,
    ),
    margin: EdgeInsets.only(bottom: AppSpaceSize.large),
    width: 400,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
