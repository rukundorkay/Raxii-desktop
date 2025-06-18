import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/home/controllers/home_controller.dart';
import 'package:raxii_desktop/app/modules/home/views/account_setting_view.dart';
import 'package:raxii_desktop/app/modules/home/views/facility_service_view%20.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

void showSettingsDialog(BuildContext context, HomeController controller) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.3,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: AppFontSize.large,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildMenuItem(
                        icon: Icons.person,
                        title: 'Account',
                        isSelected: controller.selectedMenuSettings.value ==
                            SettingsMenu.account,
                        onTap: () =>
                            controller.changeSetting(SettingsMenu.account),
                      ),
                      buildMenuItem(
                        icon: Icons.settings,
                        title: 'Station',
                        isSelected: controller.selectedMenuSettings.value ==
                            SettingsMenu.station,
                        onTap: () =>
                            controller.changeSetting(SettingsMenu.station),
                      ),
                      buildMenuItem(
                        icon: Icons.print,
                        title: 'Printers',
                        isSelected: controller.selectedMenuSettings.value ==
                            SettingsMenu.printer,
                        onTap: () =>
                            controller.changeSetting(SettingsMenu.printer),
                      ),
                    ],
                  ),
                ),
                // Vertical divider
                Container(
                  width: 1,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                if (controller.selectedMenuSettings.value ==
                    SettingsMenu.account) ...[
                  const AccountSetting(),
                ] else if (controller.selectedMenuSettings.value ==
                    SettingsMenu.station) ...[
                  const ServiceSetting(),
                ]
              ],
            ),
          ),
        ),
      );
    },
  );
}
