import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii/app/core/services/setting_service.dart';
import 'package:raxii/app/modules/home/controllers/home_controller.dart';
import 'package:raxii/app/modules/home/views/ethernet_configuration_view.dart';
import 'package:raxii/app/modules/home/views/setting_title.dart';
import 'package:raxii/app/shared/enum.dart';
import 'package:raxii/app/shared/size.dart';
import 'package:raxii/app/theme/app_colors.dart';

class PrinterSetting extends GetView<HomeController> {
  const PrinterSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        flex: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SettingTitle(
                    title: "Printer",
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Center(
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: AppColors.softGray.withOpacity(0.5),
                          ),
                          width: 500,
                          child: Column(children: [
                            ListTile(
                              onTap: () {
                                controller.isEthernetConfigurationSelected
                                    .value = false;
                                SettingService.to
                                    .selectPrinter(PrinterType.usb);
                              },
                              title: Text(
                                "${PrinterType.usb.name} printer",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: (SettingService.to.selectedPrinterType
                                                  .value !=
                                              null &&
                                          SettingService.to.selectedPrinterType
                                                  .value! ==
                                              PrinterType.usb)
                                      ? AppColors.primary
                                      : AppColors.deepForestGreen,
                                ),
                              ),
                              trailing: Icon(
                                (SettingService.to.selectedPrinterType.value !=
                                            null &&
                                        SettingService.to.selectedPrinterType
                                                .value! ==
                                            PrinterType.usb)
                                    ? Icons.check
                                    : Icons.arrow_forward_ios,
                                size: AppSpaceSize.defaultS + 4,
                                color: (SettingService
                                                .to.selectedPrinterType.value !=
                                            null &&
                                        SettingService.to.selectedPrinterType
                                                .value! ==
                                            PrinterType.usb)
                                    ? AppColors.primary
                                    : AppColors.deepForestGreen,
                              ),
                            ),
                            Divider(
                              color: AppColors.deepForestGreen.withOpacity(0.2),
                            ),
                            ListTile(
                              onTap: () {
                                controller
                                        .isEthernetConfigurationSelected.value =
                                    !controller
                                        .isEthernetConfigurationSelected.value;
                                SettingService.to
                                    .selectPrinter(PrinterType.ethernet);
                              },
                              title: Text(
                                "${PrinterType.ethernet.name} printer",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: (SettingService.to.selectedPrinterType
                                                  .value !=
                                              null &&
                                          SettingService.to.selectedPrinterType
                                                  .value! ==
                                              PrinterType.ethernet)
                                      ? AppColors.primary
                                      : AppColors.deepForestGreen,
                                ),
                              ),
                              subtitle: SettingService
                                          .to
                                          .selectedEthernetPrinterIpAddress
                                          .value !=
                                      null
                                  ? Text(
                                      "IP:${SettingService.to.selectedEthernetPrinterIpAddress.value!}, Port:${SettingService.to.selectedEthernetPrinterPort.value!}",
                                    )
                                  : null,
                              trailing: Icon(
                                (SettingService.to.selectedPrinterType.value !=
                                            null &&
                                        SettingService.to.selectedPrinterType
                                                .value! ==
                                            PrinterType.ethernet)
                                    ? Icons.check
                                    : Icons.arrow_forward_ios,
                                size: AppSpaceSize.defaultS + 4,
                                color: (SettingService
                                                .to.selectedPrinterType.value !=
                                            null &&
                                        SettingService.to.selectedPrinterType
                                                .value! ==
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
            ),
            if (controller.isEthernetConfigurationSelected.value) ...[
              Container(
                width: 1,
                color: AppColors.softGray,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              const Flexible(
                flex: 2,
                child: EthernetConfigurationView(),
              )
            ],
          ],
        ),
      ),
    );
  }
}
