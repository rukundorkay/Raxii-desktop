import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raxii_desktop/app/shared/enum.dart';
class SettingService extends GetxService {
  static SettingService get to => Get.find();
  final selectedPrinterType = Rx<PrinterType?>(null);
  final _storage = GetStorage();

  void selectPrinter(PrinterType printerType) {
    if (selectedPrinterType.value != null &&
        selectedPrinterType.value! == printerType) {
      selectedPrinterType.value = null;
      _storage.remove('selected_printer_type');
    } else {
      selectedPrinterType.value = printerType;
      _storage.write('selected_printer_type', printerType.name);
    }
  }
}
