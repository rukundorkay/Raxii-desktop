import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/core/services/facility_service.dart';
import 'package:raxii_desktop/app/modules/home/views/chekin_view.dart';
import 'package:raxii_desktop/app/modules/home/views/setting_view.dart';
import 'package:raxii_desktop/app/modules/home/views/subscription_view.dart';
import 'package:raxii_desktop/app/shared/app_path.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softGray,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.white,
        centerTitle: false,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: AppSpaceSize.large),
                    width: 100,
                    child: Image.asset(
                      AppPath.logo,
                      color: AppColors.primary,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Flexible(
                  flex: 3,
                  // width: 600,
                  child: Builder(
                    builder: (BuildContext context) => TabBar(
                      dividerHeight: 0,
                      controller: TabController(
                        length: 4,
                        vsync: Scaffold.of(context),
                        initialIndex: 0,
                      ),
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primary,
                      tabs: [
                        Tab(
                          child: Text(
                            "Check-in",
                            style: TextStyle(
                              fontSize: AppFontSize.defaultS,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Subscription",
                            style: TextStyle(
                              fontSize: AppFontSize.defaultS,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Attendance",
                            style: TextStyle(
                              fontSize: AppFontSize.defaultS,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Insight",
                            style: TextStyle(
                              fontSize: AppFontSize.defaultS,
                            ),
                          ),
                        ),
                      ],
                      onTap: controller.changeTab,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.softGray,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpaceSize.large,
                      vertical: AppSpaceSize.defaultS,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: AppSpaceSize.large,
                    ),
                    child: PopupMenuButton<int>(
                      color: AppColors.softGray,
                      offset: const Offset(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.settings, size: 20),
                              SizedBox(width: 8),
                              Text('Settings'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(Icons.logout,
                                  size: 20, color: AppColors.alertRed),
                              SizedBox(width: 8),
                              Text('Logout',
                                  style: TextStyle(color: AppColors.alertRed)),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 0) {
                          showSettingsDialog(context, controller);
                        } else if (value == 1) {
                          AuthService.to.logout();
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          SizedBox(
                            width: AppSpaceSize.tiny,
                          ),
                          Obx(
                            () => AuthService.to.user.value != null
                                ? Text(
                                    "${AuthService.to.user.value!.firstName} (${FacilityService.to.selectedService.value != null ? FacilityService.to.selectedService.value!.name : ''})",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => IndexedStack(
                  index: controller.selectedTabIndex.value,
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppSpaceSize.defaultS),
                      child: const CheckinView(),
                    ),
                    const SubscriptionView(),
                    // Container(
                    //     margin: EdgeInsets.symmetric(
                    //       horizontal: AppSpaceSize.large,
                    //       vertical: AppSpaceSize.enormous,
                    //     ),
                    //     child: const ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
