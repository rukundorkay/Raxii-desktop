import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/data/models/service.dart';
import 'package:raxii_desktop/app/data/providers/facility_services_provider.dart';

class FacilityService extends GetxService {
  static FacilityService get to => Get.find();
  final facilityServices = <Service>[].obs;
  final isLoading = false.obs;
  final selectedService = Rx<Service?>(null);

  @override
  void onInit() {
    getService();
    super.onInit();
  }

  Future<List<Service>> getService() async {
    if (facilityServices.isEmpty) {
      isLoading.value = true;
      final response = await FacilityServicesProvider.to
          .getServices(accessToken: AuthService.to.user.value!.accessToken!);
      isLoading.value = false;
      if (response.isRight) {
        facilityServices.value = response.right;
      }
    } else {
      print("something went wrong");
    }
    return facilityServices;
  }

  void selectService(Service service) {
    if (selectedService.value != null &&
        selectedService.value!.id == service.id) {
      selectedService.value = null;
    } else {
      selectedService.value = service;
    }
  }
}
