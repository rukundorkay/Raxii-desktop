import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii/app/modules/home/controllers/home_controller.dart';
import 'package:raxii/app/theme/app_colors.dart';

class SubscriptionDurationCriteria extends GetView<HomeController> {
  const SubscriptionDurationCriteria({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      initiallyExpanded: true,
      title: const Text('Select Duration',
          style: TextStyle(
            color: AppColors.deepForestGreen,
            fontWeight: FontWeight.w500,
          )),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: controller.durations.map((duration) {
                return FilterChip(
                  selectedColor: AppColors.teaGreen,
                  label: Text(duration.name),
                  selected: controller.selectedDuration.value == duration,
                  onSelected: (isSelected) {
                    controller.toggleDurationSelection(duration);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
