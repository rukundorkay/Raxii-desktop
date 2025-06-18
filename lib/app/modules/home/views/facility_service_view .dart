import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/facility_service.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class ServiceSetting extends StatelessWidget {
  const ServiceSetting({
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
            'Station',
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
                  child: Column(
                    children: [
                      for (var service
                          in FacilityService.to.facilityServices) ...[
                        ListTile(
                          onTap: () =>
                              FacilityService.to.selectService(service),
                          title: Text(
                            service.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color:
                                  (FacilityService.to.selectedService.value !=
                                              null &&
                                          FacilityService.to.selectedService
                                                  .value!.id ==
                                              service.id)
                                      ? AppColors.primary
                                      : AppColors.deepForestGreen,
                            ),
                          ),
                          trailing: Icon(
                            (FacilityService.to.selectedService.value != null &&
                                    FacilityService
                                            .to.selectedService.value!.id ==
                                        service.id)
                                ? Icons.check
                                : Icons.arrow_forward_ios,
                            size: AppSpaceSize.defaultS + 4,
                            color: (FacilityService.to.selectedService.value !=
                                        null &&
                                    FacilityService
                                            .to.selectedService.value!.id ==
                                        service.id)
                                ? AppColors.primary
                                : AppColors.deepForestGreen,
                          ),
                        ),
                        if (FacilityService.to.facilityServices.last.id !=
                            service.id)
                          Divider(
                            color: AppColors.deepForestGreen.withOpacity(0.2),
                          )
                      ]
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
