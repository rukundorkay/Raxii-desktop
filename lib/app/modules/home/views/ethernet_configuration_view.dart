import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii/app/core/services/setting_service.dart';
import 'package:raxii/app/modules/home/controllers/home_controller.dart';
import 'package:raxii/app/modules/login/widgets/app_form_field.dart';
import 'package:raxii/app/shared/size.dart';
import 'package:raxii/app/theme/app_colors.dart';

class EthernetConfigurationView extends GetView<HomeController> {
  const EthernetConfigurationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: AppSpaceSize.defaultS + AppSpaceSize.enormous),
      padding: EdgeInsets.all(AppSpaceSize.defaultS),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.softGray.withOpacity(0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Ethernet Printer Configuration",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.medium,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpaceSize.large),
          AppTextField(
            label: "Ip Address",
            hintText: "Ex:192.168.89.1",
            controller: controller.ipAddressController,
          ),
          SizedBox(height: AppSpaceSize.defaultS),
          AppTextField(
            label: "Port Number",
            hintText: "Ex:9090",
            controller: controller.portController,
          ),
          SizedBox(height: AppSpaceSize.large),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.isEthernetConfigurationSelected.value = false;
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: AppSpaceSize.defaultS),
                    backgroundColor: AppColors.alertRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpaceSize.tiny),
                    ),
                  ),
                  child: Text(
                    'cancel',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: AppSpaceSize.defaultS,
              ),
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () => controller.setEthernetPrinter(context),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: AppSpaceSize.defaultS),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpaceSize.tiny),
                      ),
                    ),
                    child: controller.isConnectingEthernetPrinterLoading.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          )
                        : Text(
                            'Test and Save',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
