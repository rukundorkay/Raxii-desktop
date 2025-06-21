import 'package:get/get.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/data/models/partner.dart';
import 'package:raxii_desktop/app/data/providers/partner_provider.dart';

class PartnerService extends GetxService {
  static PartnerService get to => Get.find();

  final partners = <Partner>[].obs;
  final isLoading = false.obs;
  final selectedPartner = Rx<Partner?>(null);

  Future<void> getPartner() async {
    if (partners.isEmpty) {
      isLoading.value = true;
      final response = await PartnerProvider.to
          .getPartners(accesstoken: AuthService.to.user.value!.accessToken!);
      isLoading.value = false;
      if (response.isRight) {
        partners.value = response.right;
      }
    }
  }
}
