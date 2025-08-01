import 'package:get/get.dart';
import 'package:raxii/app/core/services/auth_service.dart';
import 'package:raxii/app/data/models/service.dart';
import 'package:raxii/app/data/providers/facility_services_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class FacilityService extends GetxService {
  static FacilityService get to => Get.find();
  final facilityServices = <Service>[].obs;
  final isLoading = false.obs;
  final selectedService = Rx<Service?>(null);
  final _storage = GetStorage();

  @override
  void onInit() {
    getService();
    readServiceFromStorage();
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
      _storage.remove('selected_service');
    } else {
      selectedService.value = service;
      _storage.write('selected_service', jsonEncode(service.toJson()));
    }
  }

  void readServiceFromStorage() {
    // Restore selected service from storage
    final stored = _storage.read('selected_service');
    if (stored != null) {
      try {
        final map = jsonDecode(stored);
        selectedService.value = Service.fromJson(map);
      } catch (e) {
        selectedService.value = null;
      }
    }
  }
}
