import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/modules/home/views/chekin_view.dart';
import 'package:raxii_desktop/app/shared/app_path.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.3,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: AppFontSize.large,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildMenuItem(
                        Icons.person,
                        'Account',
                        controller.selectedMenuSettings.value ==
                            SettingsMenu.account,
                      ),
                      _buildMenuItem(
                        Icons.settings,
                        'Service',
                        controller.selectedMenuSettings.value ==
                            SettingsMenu.service,
                      ),
                      _buildMenuItem(
                        Icons.print,
                        'Printers',
                        controller.selectedMenuSettings.value ==
                            SettingsMenu.printer,
                      ),
                    ],
                  ),
                ),
                // Vertical divider
                Container(
                  width: 1,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                // Right column - User details
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: TextStyle(
                          fontSize: AppFontSize.large,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetail('Name',
                                  "${AuthService.to.user.value?.firstName} ${AuthService.to.user.value?.lastName}"),
                              _buildDetail(
                                  'Role', AuthService.to.user.value!.role.name),
                              _buildDetail('Phone Number',
                                  AuthService.to.user.value!.phoneNumber),
                              _buildDetail(
                                  'Business',
                                  AuthService
                                      .to.user.value!.businessFacility.name),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(IconData icon, String title, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.softGray : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppSpaceSize.tiny,
        horizontal: AppSpaceSize.defaultS,
      ),
      margin: EdgeInsets.symmetric(
        vertical: AppSpaceSize.tiny,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.softGray,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.symmetric(
        vertical: AppSpaceSize.tiny,
        horizontal: AppSpaceSize.defaultS,
      ),
      margin: EdgeInsets.only(bottom: AppSpaceSize.large),
      width: 400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

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
                Container(
                  margin: EdgeInsets.only(left: AppSpaceSize.large),
                  width: 100,
                  child: Image.asset(
                    AppPath.logo,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
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
                          children: const [
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
                        _showSettingsDialog(context);
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
                        Text(
                          "${AuthService.to.user.value!.firstName} (GYM)",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
                    const Center(child: Text('Subscriptions Content')),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
