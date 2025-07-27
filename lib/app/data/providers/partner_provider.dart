import 'package:either_dart/either.dart';

import 'package:get/get.dart';
import 'package:raxii/app/core/constants/api_constants.dart';
import 'package:raxii/app/data/models/partner.dart';

class PartnerProvider extends GetConnect {
  static PartnerProvider get to => Get.find();
  Future<Either<String, List<Partner>>> getPartners({
    required String accesstoken,
  }) async {
    final response = await get(
      "/partner",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      },
    );

    if (response.statusCode == 200) {
      return Right((response.body["items"] as List)
          .map((dynamic v) => Partner.fromJson(v as Map<String, dynamic>))
          .toList());
    } else {
      return Left(response.body["message"]);
    }
  }

  @override
  onInit() {
    baseUrl = BASE_URL;
    timeout = const Duration(minutes: 5);
    super.onInit();
  }
}
