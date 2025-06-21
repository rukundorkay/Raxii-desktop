import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/home/controllers/home_controller.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class PaymentSummary extends GetView<HomeController> {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(AppSpaceSize.defaultS),
          child: Text(
            "Select Payment Method",
            style: TextStyle(
              fontSize: AppFontSize.medium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: AppFontSize.defaultS,
                    left: AppFontSize.enormous,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.teaGreen,
                          AppColors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: AppColors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.all(
                    AppSpaceSize.defaultS,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "MemberShip Summary".toUpperCase(),
                        style: TextStyle(
                          color: AppColors.deepForestGreen,
                          fontSize: AppFontSize.medium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: AppSpaceSize.huge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Member Names".toUpperCase(),
                            style: TextStyle(
                              color: AppColors.steelGray,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: AppSpaceSize.large,
                          ),
                          Text(
                            "${controller.fnameController.text} ${controller.lnameController.text}",
                            style: TextStyle(
                              color: AppColors.deepForestGreen,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSpaceSize.tiny,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Member Phones".toUpperCase(),
                            style: TextStyle(
                              color: AppColors.steelGray,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: AppSpaceSize.large,
                          ),
                          Text(
                            controller.phoneController.text,
                            style: TextStyle(
                              color: AppColors.deepForestGreen,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSpaceSize.defaultS,
                      ),
                      const Divider(),
                      // Row(
                      //   children: [
                      //     Text("Registration Code"),
                      //     SizedBox(
                      //       width: AppSpaceSize.large,
                      //     ),
                      //     Text("TEN_9897"),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: AppSpaceSize.tiny,
                      // ),
                      Row(
                        children: [
                          Text(
                            "Plans",
                            style: TextStyle(
                              color: AppColors.steelGray,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSpaceSize.tiny,
                      ),
                      for (var plan in controller.selectedPlans) ...[
                        Row(
                          children: [
                            Text(
                              plan.name!.toUpperCase(),
                              style: TextStyle(
                                color: AppColors.steelGray,
                                fontSize: AppFontSize.medium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: AppSpaceSize.large,
                            ),
                            Text(
                              plan.price.toString().formatAmount(),
                              style: TextStyle(
                                color: AppColors.deepForestGreen,
                                fontSize: AppFontSize.medium,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSpaceSize.tiny,
                        ),
                      ],
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              color: AppColors.steelGray,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: AppSpaceSize.large,
                          ),
                          Text(
                            controller.selectedPlans
                                .fold(0.0, (total, plan) => total + plan.price!)
                                .toString()
                                .formatAmount(),
                            style: TextStyle(
                              color: AppColors.deepForestGreen,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: AppSpaceSize.defaultS,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(
                    AppSpaceSize.defaultS,
                  ),
                  margin: EdgeInsets.only(
                    top: AppFontSize.defaultS,
                    left: AppFontSize.enormous,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.white,
                        AppColors.teaGreen,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: AppColors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: AppSpaceSize.medium),
                    itemCount: controller.paymentMethods.length,
                    itemBuilder: (context, index) => Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: controller.selectedPaymentMethod.value !=
                                          null &&
                                      controller.selectedPaymentMethod.value ==
                                          controller.paymentMethods[index]
                                  ? AppColors.primary
                                  : AppColors.softGray,
                              width: 2,
                            )),
                        child: ListTile(
                          onTap: () {
                            controller.selectPaymentMethod(
                                controller.paymentMethods[index]);
                          },
                          leading: Checkbox(
                            activeColor: AppColors.primary,
                            value: controller.selectedPaymentMethod.value !=
                                    null &&
                                controller.selectedPaymentMethod.value ==
                                    controller.paymentMethods[index],
                            onChanged: (value) {
                              controller.selectPaymentMethod(
                                  controller.paymentMethods[index]);
                            },
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(
                              left: AppFontSize.defaultS,
                            ),
                            child: Text(
                              controller.paymentMethods[index].name,
                              style: TextStyle(
                                color: AppColors.darkNavyBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
