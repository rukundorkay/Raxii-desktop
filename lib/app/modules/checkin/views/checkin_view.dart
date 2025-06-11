import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';
import '../controllers/checkin_controller.dart';

class CheckinView extends GetView<CheckinController> {
  const CheckinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softGray,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        title: Container(
          width: 150,
          child: Image.asset(
            'assets/png/raxii.png',
            color: AppColors.primary,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
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
                    tabs: const [
                      Tab(text: 'Check-in'),
                      Tab(text: 'Subscriptions'),
                    ],
                    onTap: controller.changeTab,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(() => TextFormField(
                            decoration: InputDecoration(
                              hintText: controller.isBarcodeSearch.value
                                  ? 'Search by barcode'
                                  : 'Search by phone number',
                              prefixIcon: IconButton(
                                icon: Icon(
                                  controller.isBarcodeSearch.value
                                      ? Icons.qr_code_scanner
                                      : Icons.phone,
                                ),
                                onPressed: controller.toggleSearchType,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            onChanged: controller.handleSearch,
                            keyboardType: controller.isBarcodeSearch.value
                                ? TextInputType.text
                                : TextInputType.phone,
                          )),
                    ),
                    Center(child: Text('Subscriptions Content')),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
