import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/modules/home/views/chekin_view.dart';
import 'package:raxii_desktop/app/routes/app_pages.dart';
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
        title: SizedBox(
          width: 100,
          child: Image.asset(
            AppPath.logo,
            color: AppColors.primary,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Row(
            children: [
              SizedBox(
                width: 300,
                child: Builder(
                  builder: (BuildContext context) => TabBar(
                    dividerHeight: 0,
                    controller: TabController(
                      length: 2,
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
                    ],
                    onTap: controller.changeTab,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpaceSize.large,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: AppSpaceSize.defaultS,
                      color: AppColors.alertRed,
                    ),
                    SizedBox(width: AppSpaceSize.tiny),
                    InkWell(
                      onTap: () => Get.offAllNamed(Routes.LOGIN),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          color: AppColors.alertRed,
                          fontSize: AppFontSize.defaultS,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                    const Center(child: Text('Subscriptions Content')),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
