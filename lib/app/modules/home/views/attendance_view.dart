
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';
import 'package:raxii_desktop/app/shared/extension/dateTime.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSpaceSize.large,
        vertical: AppSpaceSize.enormous,
      ),
      padding: EdgeInsets.only(top: AppSpaceSize.defaultS),
      color: AppColors.white,
      child: Obx(
        () => Column(
          children: [
            Text(
              "TODAY ATTENDANCE",
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.medium,
              ),
            ),
            SizedBox(
              height: AppSpaceSize.large,
            ),
            AttendanceService.to.isGetAttendanceLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: AttendanceService.to.allAttendance.length,
                      separatorBuilder: (context, index) => Divider(
                        color: AppColors.softGray,
                      ),
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.teaGreen,
                          child: Text(
                            AttendanceService
                                .to.allAttendance[index].memberNames.avatar,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: AppFontSize.defaultS,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AttendanceService
                                  .to.allAttendance[index].memberNames,
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: AppFontSize.defaultS,
                              ),
                            ),
                            Text(
                              " LOCKER(${AttendanceService.to.allAttendance[index].lockerRoom})",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: AppFontSize.defaultS,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          AttendanceService
                              .to.allAttendance[index].memberPhoneNumber
                              .replaceAll("25", ""),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: AppFontSize.tiny,
                          ),
                        ),
                        trailing: Column(
                          children: [
                            Text(
                              AttendanceService
                                  .to.allAttendance[index].attendanceDate
                                  .toFormattedTime(),
                              style: TextStyle(
                                fontSize: AppFontSize.defaultS,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              height: AppSpaceSize.tiny,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.teaGreen,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpaceSize.tiny,
                              ),
                              child: Text(
                                AttendanceService
                                    .to.allAttendance[index].serviceName,
                                style: TextStyle(
                                  fontSize: AppFontSize.tiny,
                                  color: AppColors.deepForestGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
