import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raxii/app/core/constants/api_constants.dart';
import 'package:raxii/app/data/models/service.dart';

class FacilityServicesProvider extends GetConnect {
  static FacilityServicesProvider get to => Get.find();
  Future<Either<String, List<Service>>> getServices(
      {required String accessToken}) async {
    final response = await get(
      "/business-service",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return Right((response.body["items"] as List)
          .map((dynamic v) => Service.fromJson(v as Map<String, dynamic>))
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
