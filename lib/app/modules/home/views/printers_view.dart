import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/facility_service.dart';
import 'package:raxii_desktop/app/core/services/setting_service.dart';
import 'package:raxii_desktop/app/shared/enum.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class PrinterSetting extends StatelessWidget {
  const PrinterSetting({
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
            'Printer',
            style: TextStyle(
              fontSize: AppFontSize.large,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Center(
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: AppColors.softGray,
                  ),
                  width: 500,
                  child: Column(children: [
                    ListTile(
                      onTap: () =>
                          SettingService.to.selectPrinter(PrinterType.usb),
                      title: Text(
                        "${PrinterType.usb.name} printer",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: (SettingService.to.selectedPrinterType.value !=
                                      null &&
                                  SettingService
                                          .to.selectedPrinterType.value! ==
                                      PrinterType.usb)
                              ? AppColors.primary
                              : AppColors.deepForestGreen,
                        ),
                      ),
                      trailing: Icon(
                        (SettingService.to.selectedPrinterType.value != null &&
                                SettingService.to.selectedPrinterType.value! ==
                                    PrinterType.usb)
                            ? Icons.check
                            : Icons.arrow_forward_ios,
                        size: AppSpaceSize.defaultS + 4,
                        color: (SettingService.to.selectedPrinterType.value !=
                                    null &&
                                SettingService.to.selectedPrinterType.value! ==
                                    PrinterType.usb)
                            ? AppColors.primary
                            : AppColors.deepForestGreen,
                      ),
                    ),
                    Divider(
                      color: AppColors.deepForestGreen.withOpacity(0.2),
                    ),
                    ListTile(
                      onTap: () =>
                          SettingService.to.selectPrinter(PrinterType.ethernet),
                      title: Text(
                        "${PrinterType.ethernet.name} printer",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: (SettingService.to.selectedPrinterType.value !=
                                      null &&
                                  SettingService
                                          .to.selectedPrinterType.value! ==
                                      PrinterType.ethernet)
                              ? AppColors.primary
                              : AppColors.deepForestGreen,
                        ),
                      ),
                      trailing: Icon(
                        (SettingService.to.selectedPrinterType.value != null &&
                                SettingService.to.selectedPrinterType.value! ==
                                    PrinterType.ethernet)
                            ? Icons.check
                            : Icons.arrow_forward_ios,
                        size: AppSpaceSize.defaultS + 4,
                        color: (SettingService.to.selectedPrinterType.value !=
                                    null &&
                                SettingService.to.selectedPrinterType.value! ==
                                    PrinterType.ethernet)
                            ? AppColors.primary
                            : AppColors.deepForestGreen,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
