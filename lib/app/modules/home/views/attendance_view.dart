import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';
import 'package:raxii_desktop/app/shared/extension/dateTime.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/shared/widget/detail_tile.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppSpaceSize.defaultS,
            vertical: AppSpaceSize.enormous,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        color: AppColors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: AppSpaceSize.defaultS,
                                bottom: AppSpaceSize.medium,
                              ),
                              child: Text(
                                "Attendance (${AttendanceService.to.allAttendance.length})",
                                style: TextStyle(
                                  fontSize: AppFontSize.medium + 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSpaceSize.defaultS,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: AppColors.softGray,
                              ),
                              child: TextFormField(
                                onChanged: (value) => AttendanceService.to
                                    .searchAttendance(value),
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.search, size: 16),
                                    hintText: "Search by Name or Phone",
                                    hintStyle: TextStyle(
                                        color: AppColors.deepForestGreen,
                                        fontSize: AppFontSize.defaultS)),
                              ),
                            ),
                            SizedBox(
                              height: AppSpaceSize.defaultS,
                            ),
                            AttendanceService.to.isGetAttendanceLoading.value
                                ? const Expanded(
                                    child: Center(
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                                : AttendanceService.to.allAttendance.isEmpty
                                    ? Expanded(
                                        child: Center(
                                          child: Text(
                                            "No Attendance found on this ${AttendanceService.to.selectedDate.value!.formatAttendanceDate()}",
                                            style: TextStyle(
                                              fontSize: AppFontSize.defaultS,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: ListView.separated(
                                            itemBuilder: (context, index) {
                                              final attendance = AttendanceService
                                                      .to
                                                      .searchedAttendances
                                                      .isNotEmpty
                                                  ? AttendanceService.to
                                                          .searchedAttendances[
                                                      index]
                                                  : AttendanceService
                                                      .to.allAttendance[index];
                                              return Container(
                                                color: AttendanceService
                                                                .to
                                                                .selectedAttendance
                                                                .value !=
                                                            null &&
                                                        attendance
                                                                .attendanceId ==
                                                            AttendanceService
                                                                .to
                                                                .selectedAttendance
                                                                .value!
                                                                .attendanceId
                                                    ? AppColors.teaGreen
                                                        .withOpacity(0.5)
                                                    : null,
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal:
                                                        AppSpaceSize.defaultS,
                                                  ),
                                                  onTap: () => AttendanceService
                                                      .to
                                                      .selectAttendance(
                                                          attendance),
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.teaGreen,
                                                    child: Text(
                                                      attendance
                                                          .memberNames.avatar,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: AppFontSize
                                                            .defaultS,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    attendance.memberNames,
                                                    style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize:
                                                          AppFontSize.tiny,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      Text(
                                                        attendance
                                                            .memberPhoneNumber
                                                            .replaceAll(
                                                                "25", ""),
                                                        style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize:
                                                              AppFontSize.tiny,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      attendance.lockerRoom ==
                                                              null
                                                          ? const SizedBox()
                                                          : Text(
                                                              " Locker(${attendance.lockerRoom})",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primary,
                                                                fontSize:
                                                                    AppFontSize
                                                                        .defaultS,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  trailing: Column(
                                                    children: [
                                                      Text(
                                                        attendance
                                                            .attendanceDate
                                                            .toFormattedTime(),
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .defaultS,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            AppSpaceSize.tiny,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .teaGreen,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              AppSpaceSize.tiny,
                                                        ),
                                                        child: Text(
                                                          attendance
                                                              .serviceName,
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppFontSize
                                                                    .tiny,
                                                            color: AppColors
                                                                .deepForestGreen,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => Divider(
                                                      color: AppColors.softGray,
                                                      height: 0,
                                                    ),
                                            itemCount: AttendanceService
                                                    .to
                                                    .searchedAttendances
                                                    .isNotEmpty
                                                ? AttendanceService.to
                                                    .searchedAttendances.length
                                                : AttendanceService
                                                    .to.allAttendance.length),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: AppColors.softGray,
              ),
              if (AttendanceService.to.selectedAttendance.value != null) ...[
                Flexible(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(AppSpaceSize.defaultS),
                      color: AppColors.white,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              AttendanceService.to.selectedAttendance.value =
                                  null;
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                  color: AppColors.black,
                                ),
                                SizedBox(
                                  width: AppSpaceSize.tiny,
                                ),
                                Text(
                                  "Details",
                                  style: TextStyle(
                                    fontSize: AppFontSize.medium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppSpaceSize.large,
                          ),
                          DetailTile(
                              label: "Names",
                              value: AttendanceService
                                  .to.selectedAttendance.value!.memberNames),
                          DetailTile(
                            label: "Phone Number",
                            value: AttendanceService
                                .to.selectedAttendance.value!.memberPhoneNumber,
                          ),
                          DetailTile(
                              label: "Registration Code",
                              value: AttendanceService.to.selectedAttendance
                                  .value!.memberRegistrationCode),
                          DetailTile(
                            label: "Date",
                            value: AttendanceService
                                .to.selectedAttendance.value!.attendanceDate
                                .formatAttendanceDate(),
                          ),
                          DetailTile(
                              label: "Service",
                              value: AttendanceService
                                  .to.selectedAttendance.value!.serviceName),
                          DetailTile(
                            label: "Locker Room",
                            value: AttendanceService
                                    .to.selectedAttendance.value!.lockerRoom ??
                                "N/A".toString(),
                          ),
                          SizedBox(
                            height: AppSpaceSize.large,
                          ),
                        ],
                      ),
                    ))
              ] else ...[
                Flexible(
                  flex: 4,
                  child: Container(
                    color: AppColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 400,
                              height: 400,
                              color: AppColors.white,
                              child: SfCalendar(
                                maxDate: DateTime.now(),
                                view: CalendarView.month,
                                onTap: (value) {
                                  AttendanceService.to
                                      .getAttendance(endDate: value.date!);
                                },
                                monthViewSettings: const MonthViewSettings(
                                  appointmentDisplayMode:
                                      MonthAppointmentDisplayMode.appointment,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ]
            ],
          )),
    );
  }
}
