import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii/app/modules/home/controllers/home_controller.dart';
import 'package:raxii/app/modules/login/widgets/app_form_field.dart';
import 'package:raxii/app/shared/size.dart';
import 'package:raxii/app/theme/app_colors.dart';

class MemberInformation extends GetView<HomeController> {
  const MemberInformation({super.key});

  Widget buildMemberInfoStep(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpaceSize.huge,
          vertical: AppSpaceSize.defaultS,
        ),
        padding: EdgeInsets.all(AppSpaceSize.defaultS),
        color: AppColors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 7,
                  child: AppTextField(
                    controller: controller.phoneController,
                    label: "Phone Number",
                    hintText: "Search Member Phone number",
                  ),
                ),
                SizedBox(width: AppSpaceSize.defaultS),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () => controller.searchMember(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpaceSize.defaultS + 6,
                      ),
                    ),
                    child: Obx(() => controller.isSearchingMemebr.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : const Text("Verify")),
                  ),
                ),
              ],
            ),
            Obx(() {
              final isExisting = controller.isExistingMember.value;
              if (isExisting == null) return SizedBox();

              return Container(
                margin: EdgeInsets.only(top: AppSpaceSize.enormous),
                child: Column(
                  children: [
                    SizedBox(height: AppSpaceSize.defaultS),
                    Text(
                      "Member Information",
                      style: TextStyle(
                        fontSize: AppFontSize.medium,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: AppSpaceSize.defaultS),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: AppTextField(
                            readOnly: isExisting,
                            controller: controller.fnameController,
                            label: "First Name",
                            hintText: "Enter your first name",
                          ),
                        ),
                        SizedBox(width: AppSpaceSize.defaultS),
                        Expanded(
                          flex: 6,
                          child: AppTextField(
                            readOnly: isExisting,
                            controller: controller.lnameController,
                            label: "LastName",
                            hintText: "Enter your last name",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpaceSize.defaultS),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: AppTextField(
                            controller: controller.cardController,
                            label: "Card",
                            hintText: "enter card number",
                          ),
                        ),
                        SizedBox(width: AppSpaceSize.defaultS),
                        if (!isExisting)
                          Expanded(
                            flex: 6,
                            child: AppTextField(
                              controller: controller.otpController,
                              label: "OTP",
                              hintText:
                                  "enter otp sent on ${controller.phoneController.text}",
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMemberInfoStep(context);
  }
}
