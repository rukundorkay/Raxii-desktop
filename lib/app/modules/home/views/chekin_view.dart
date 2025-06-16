import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';
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
                  if (!AttendanceService.to.isCheckinsLoading.value) ...[
                    if (AttendanceService.to.currentAttendance.value !=
                        null) ...[
                      Text(
                        "Member Profile",
                        style: TextStyle(
                          fontSize: AppSpaceSize.medium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: AppSpaceSize.large),
                      Column(
                        children: [
                          _ProfileRow(
                            icon: Icons.person,
                            label: "Names",
                            value: AttendanceService
                                .to.currentAttendance.value!.memberNames,
                          ),
                          SizedBox(height: AppSpaceSize.defaultS),
                          _ProfileRow(
                            icon: Icons.settings,
                            label: "Service",
                            value: AttendanceService
                                .to.currentAttendance.value!.serviceName,
                          ),
                          SizedBox(height: AppSpaceSize.defaultS),
                          _ProfileRow(
                            icon: Icons.phone,
                            label: "Phone Number",
                            value: AttendanceService.to.currentAttendance
                                .value!.memberPhoneNumber,
                          ),
                          SizedBox(height: AppSpaceSize.defaultS),
                          _ProfileRow(
                            icon: Icons.grid_3x3,
                            label: "Registration Code",
                            value: AttendanceService.to.currentAttendance
                                .value!.memberRegistrationCode,
                          ),
                        ],
                      ),
                    ] else ...[
                      const Text("No results Found")
                    ]
                  ] else ...[
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  ]
                ],
              ),
            )
          ],
        ));
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(width: AppSpaceSize.tiny),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.medium,
          ),
        ),
        SizedBox(width: AppSpaceSize.medium),
        Flexible(
          child: Text(
            style: TextStyle(
              fontSize: AppFontSize.medium,
            ),
            value,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
