import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii/app/modules/home/controllers/home_controller.dart';
import 'package:raxii/app/shared/extension/string.dart';
import 'package:raxii/app/shared/size.dart';
import 'package:raxii/app/theme/app_colors.dart';

class PlanSelection extends GetView<HomeController> {
  const PlanSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.plans.isEmpty
        ? Center(
            child: Text(
              "\" Oops! No subscription plan matches the criteria you provided\" ",
              style: TextStyle(
                fontSize: AppFontSize.medium,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: AppSpaceSize.defaultS,
              ),
              Text(
                "Select Suitable  Membership Plan",
                style: TextStyle(
                  fontSize: AppFontSize.medium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: AppSpaceSize.enormous,
                    left: AppFontSize.enormous * 2,
                    right: AppFontSize.enormous * 2,
                  ),
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppSpaceSize.medium),
                      itemCount: controller.plans.length,
                      itemBuilder: (context, index) => Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  gradient: controller.selectedPlans
                                          .contains(controller.plans[index])
                                      ? LinearGradient(
                                          colors: [
                                            AppColors.teaGreen,
                                            AppColors.white,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.selectedPlans
                                            .contains(controller.plans[index])
                                        ? AppColors.primary
                                        : AppColors.softGray,
                                    width: 2,
                                  )),
                              child: ListTile(
                                onTap: () {
                                  controller
                                      .selectPlan(controller.plans[index]);
                                },
                                leading: Checkbox(
                                  activeColor: AppColors.primary,
                                  value: controller.selectedPlans
                                      .contains(controller.plans[index]),
                                  onChanged: (value) {
                                    controller
                                        .selectPlan(controller.plans[index]);
                                  },
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(
                                    left: AppFontSize.defaultS,
                                  ),
                                  child: Text(
                                    controller.plans[index].name!,
                                    style: TextStyle(
                                      color: AppColors.darkNavyBlue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(
                                    top: AppSpaceSize.tiny,
                                    left: AppFontSize.defaultS,
                                  ),
                                  child: Wrap(
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    children: controller
                                        .plans[index].coverdServices!
                                        .map((coveredService) {
                                      return Chip(
                                        backgroundColor: AppColors.teaGreen,
                                        side: BorderSide.none,
                                        label: Text(coveredService.name),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                trailing: Text(
                                  controller.plans[index].price
                                      .toString()
                                      .formatAmount(),
                                  style: TextStyle(
                                    color: AppColors.steelGray,
                                    fontSize: AppFontSize.defaultS,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ),
            ],
          );
  }
}
