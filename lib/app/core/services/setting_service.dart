import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raxii_desktop/app/shared/enum.dart';

class SettingService extends GetxService {
  static SettingService get to => Get.find();
  final selectedPrinterType = Rx<PrinterType?>(null);
  final _storage = GetStorage();
  final selectedEthernetPrinterIpAddress = Rx<String?>(null);
  final selectedEthernetPrinterPort = Rx<String?>(null);
  // final isConnectingEthernetPrinterLoading = Rx<bool>(false);
  @override
  void onInit() {
    readPrinterFromStorage();
    setEthernetPrinter(isRead: true);
    super.onInit();
  }

  void setEthernetPrinter({
    String? ipAddress,
    int? port,
    bool isRead = false,
  }) {
    if (!isRead) {
      _storage.write(
        'selected_ethernet_printer',
        {
          'ipAddress': ipAddress,
          'port': port,
        },
      );
      selectedEthernetPrinterIpAddress.value = ipAddress;
      selectedEthernetPrinterPort.value = port.toString();
    } else {
      final stored = _storage.read('selected_ethernet_printer');
      if (stored != null) {
        selectedEthernetPrinterIpAddress.value = stored['ipAddress'];
        selectedEthernetPrinterPort.value = stored['port'].toString();
      }
    }
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
