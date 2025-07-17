import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/attandance_service.dart';
import 'package:raxii_desktop/app/shared/extension/dateTime.dart';
import 'package:raxii_desktop/app/shared/size.dart';
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
          child: Row(children: [
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
                              "Attendance",
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
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.search, size: 16),
                                  hintText: "Search  by Client Name",
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
                                                .to.allAttendance[index];
                                            return Container(
                                              // color: SubscriptionService
                                              //                 .to
                                              //                 .selectedSubscriptions
                                              //                 .value !=
                                              //             null &&
                                              //         attendance.attendanceId ==

                                              //                 .to
                                              //                 .selectedSubscriptions
                                              //                 .value!
                                              //                 .id
                                              //     ? AppColors.teaGreen
                                              //         .withOpacity(0.5)
                                              //     : null,
                                              child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal:
                                                        AppSpaceSize.defaultS,
                                                  ),
                                                  // onTap: () =>
                                                  //     SubscriptionService
                                                  //         .to
                                                  //         .selectSubscription(
                                                  //             subscriptions),
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.teaGreen,
                                                    child: Icon(
                                                      FontAwesomeIcons
                                                          .arrowTrendUp,
                                                      size: 14,
                                                      color: AppColors.primary,
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
                                                  subtitle: Text(
                                                    attendance
                                                        .memberPhoneNumber,
                                                    style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize:
                                                          AppFontSize.tiny,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  trailing: attendance
                                                              .lockerRoom ==
                                                          null
                                                      ? null
                                                      : Column(
                                                          children: [
                                                            const Text(
                                                                "Locker Room"),
                                                            Text(
                                                              attendance
                                                                      .lockerRoom ??
                                                                  "",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    AppFontSize
                                                                        .tiny,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                                color: AppColors.softGray,
                                                height: 0,
                                              ),
                                          itemCount: AttendanceService
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
            // if (SubscriptionService.to.selectedSubscriptions.value !=
            //     null) ...[
            //   Flexible(
            //       flex: 4,
            //       child: Container(
            //         padding: EdgeInsets.all(AppSpaceSize.defaultS),
            //         color: AppColors.white,
            //         child: Column(
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 SubscriptionService
            //                     .to.selectedSubscriptions.value = null;
            //               },
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.arrow_back_ios,
            //                     size: 18,
            //                     color: AppColors.black,
            //                   ),
            //                   SizedBox(
            //                     width: AppSpaceSize.tiny,
            //                   ),
            //                   Text(
            //                     "Details",
            //                     style: TextStyle(
            //                       fontSize: AppFontSize.medium,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             SizedBox(
            //               height: AppSpaceSize.large,
            //             ),
            //             DetailTile(
            //                 label: "Names",
            //                 value: SubscriptionService
            //                     .to.selectedSubscriptions.value!.memberNames),
            //             DetailTile(
            //               label: "Phone Number",
            //               value: SubscriptionService.to.selectedSubscriptions
            //                   .value!.memberPhoneNumber,
            //             ),
            //             DetailTile(
            //                 label: "Registration Code",
            //                 value: SubscriptionService
            //                     .to
            //                     .selectedSubscriptions
            //                     .value!
            //                     .memberRegistrationCode),
            //             DetailTile(
            //               label: "Plan",
            //               value: SubscriptionService
            //                   .to.selectedSubscriptions.value!.planName,
            //             ),
            //             DetailTile(
            //                 label: "Duration",
            //                 value: SubscriptionService.to
            //                     .selectedSubscriptions.value!.planDuration),
            //             DetailTile(
            //               label: "Amount",
            //               value: SubscriptionService
            //                   .to.selectedSubscriptions.value!.amount
            //                   .toString()
            //                   .formatAmount(),
            //             ),
            //             DetailTile(
            //                 label: "Payment Mode",
            //                 value: SubscriptionService.to
            //                     .selectedSubscriptions.value!.paymentMethod),
            //             SizedBox(
            //               height: AppSpaceSize.large,
            //             ),
            //             Container(
            //               decoration: BoxDecoration(
            //                 color: AppColors.primary,
            //                 borderRadius:
            //                     const BorderRadius.all(Radius.circular(10)),
            //               ),
            //               padding: EdgeInsets.symmetric(
            //                 vertical: AppSpaceSize.tiny,
            //                 horizontal: AppSpaceSize.defaultS,
            //               ),
            //               margin: EdgeInsets.only(bottom: AppSpaceSize.large),
            //               width: 400,
            //               child: Center(
            //                   child: Text(
            //                 "Receipt",
            //                 style: TextStyle(
            //                   color: AppColors.black,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               )),
            //             )
            //           ],
            //         ),
            //       ))
            // ] else ...[
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
                            view: CalendarView.month,
                            onTap: (value) {
                              AttendanceService.to
                                  .getAttendance(endDate: value.date!);
                            },
                            // dataSource: MeetingDataSource(_getDataSource()),
                            // by default the month appointment display mode set as Indicator, we can
                            // change the display mode as appointment using the appointment display
                            // mode property
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
              // ],
              )),
    );
  }
}
