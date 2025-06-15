import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/home/controllers/home_controller.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class CheckinView extends GetView<HomeController> {
  const CheckinView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: AppSpaceSize.large,
                left: AppSpaceSize.large,
                right: AppSpaceSize.large,
              ),
              padding: EdgeInsets.only(
                left: AppSpaceSize.large,
                right: AppSpaceSize.large,
                top: AppSpaceSize.large,
                bottom: AppSpaceSize.enormous,
              ),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppSpaceSize.tiny))),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Member Checkin",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: AppColors.deepForestGreen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpaceSize.defaultS),
                  Row(
                    children: [
                      const Spacer(),
                      Flexible(
                        flex: 8,
                        child: TextFormField(
                          autofocus: true,
                          style: TextStyle(
                            fontSize: AppFontSize.large,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppColors.deepForestGreen,
                              fontSize: AppFontSize.medium,
                            ),
                            hintText: controller.isBarcodeSearch.value
                                ? 'BarCode Scanning....'
                                : 'Search by phone number',
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isBarcodeSearch.value
                                    ? Icons.qr_code_scanner
                                    : Icons.phone,
                                size: 28,
                              ),
                              onPressed: controller.toggleSearchType,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSpaceSize.tiny),
                            ),
                            filled: true,
                            fillColor: AppColors.teaGreen.withOpacity(0.4),
                          ),
                          onChanged: controller.handleSearch,
                          keyboardType: controller.isBarcodeSearch.value
                              ? TextInputType.text
                              : TextInputType.phone,
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpaceSize.defaultS),
            Container(
              margin: EdgeInsets.only(
                top: AppSpaceSize.large,
                left: AppSpaceSize.large,
                right: AppSpaceSize.large,
              ),
              padding: EdgeInsets.only(
                left: AppSpaceSize.large,
                right: AppSpaceSize.large,
                top: AppSpaceSize.large,
                bottom: AppSpaceSize.enormous,
              ),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppSpaceSize.tiny))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (!controller.isSearching.value)
                          ? const Text("No results Found")
                          : SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
