import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raxii_desktop/app/shared/enum.dart';

class SettingService extends GetxService {
  static SettingService get to => Get.find();
  final selectedPrinterType = Rx<PrinterType?>(null);
  final _storage = GetStorage();
  @override
  void onInit() {
    readPrinterFromStorage();
    super.onInit();
  }

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

  void readPrinterFromStorage() {
    // Restore selected service from storage
    final stored = _storage.read('selected_printer_type');
    if (stored != null) {
      try {
        if (stored == PrinterType.usb.name) {
          selectedPrinterType.value = PrinterType.usb;
        } else if (stored == PrinterType.ethernet.name) {
          selectedPrinterType.value = PrinterType.ethernet;
        }
      } catch (e) {
        selectedPrinterType.value = null;
      }
    }
  }
}
