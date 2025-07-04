import 'dart:typed_data';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/core/services/setting_service.dart';
import 'package:raxii_desktop/app/data/models/subscriptions.dart';
import 'package:raxii_desktop/app/shared/enum.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:toastification/toastification.dart';

class PrinterService {
  /// Generates a receipt PDF document as bytes.
  Future<Uint8List> generateReceiptPdf(Subscription data) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          AuthService.to.user.value!.businessFacility.name,
                          style: pw.TextStyle(
                            fontSize: AppFontSize.tiny - 2,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          "Address: ${AuthService.to.user.value!.businessFacility.address}",
                          style: pw.TextStyle(
                            fontSize: AppFontSize.tiny - 2,
                          ),
                        ),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          "Tin: ${AuthService.to.user.value!.businessFacility.tin!}",
                          style: pw.TextStyle(
                            fontSize: AppFontSize.tiny - 2,
                          ),
                        ),
                      ]),
                ],
              ),
              separator(pageFormat: PdfPageFormat.roll80),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Member Name',
                      style: pw.TextStyle(
                        fontSize: AppFontSize.tiny - 2,
                      ),
                    ),
                    pw.Text(
                      '${data.memberNames}',
                      style: pw.TextStyle(
                        fontSize: AppFontSize.tiny - 2,
                      ),
                    ),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Member Phone',
                      style: pw.TextStyle(
                        fontSize: AppFontSize.tiny - 2,
                      ),
                    ),
                    pw.Text(
                      '${data.memberPhoneNumber}',
                      style: pw.TextStyle(
                        fontSize: AppFontSize.tiny - 2,
                      ),
                    ),
                  ]),
              separator(pageFormat: PdfPageFormat.roll80),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Receipt',
                    style: pw.TextStyle(
                      fontSize: AppFontSize.tiny - 2,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              separator(pageFormat: PdfPageFormat.roll80),
              pw.Column(
                children: [
                  pw.Row(
                    children: [
                      pw.Text(
                        'Plans',
                        style: pw.TextStyle(
                          fontSize: AppFontSize.tiny - 2,
                        ),
                      ),
                    ],
                  ),
                  ...data.plans.map((plan) => pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              plan.name!,
                              style: pw.TextStyle(
                                fontSize: AppFontSize.tiny - 2,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              plan.price.toString().formatAmount(),
                              style: pw.TextStyle(
                                fontSize: AppFontSize.tiny - 2,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              separator(pageFormat: PdfPageFormat.roll80),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  // Replace with QR code generation for PDF
                  pw.Container(
                    height: 60,
                    width: 60,
                    child: pw.Center(
                      child: pw.BarcodeWidget(
                          barcode: pw.Barcode.qrCode(),
                          data: data.memberRegistrationCode!),
                    ),
                  ),
                ],
              ),
              separator(pageFormat: PdfPageFormat.roll80),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Payment Method',
                    style: pw.TextStyle(fontSize: AppFontSize.tiny - 2),
                  ),
                  pw.Text(
                    "${data.paymentMethod}",
                    style: pw.TextStyle(fontSize: AppFontSize.tiny - 2),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total',
                    style: pw.TextStyle(
                      fontSize: AppFontSize.tiny - 2,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    data.plans
                        .fold(0.0, (total, plan) => total + plan.price!)
                        .toString()
                        .formatAmount(),
                    style: pw.TextStyle(
                      fontSize: AppFontSize.tiny - 2,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              separator(pageFormat: PdfPageFormat.roll80),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Thank you !!',
                    style: pw.TextStyle(
                      fontSize: AppFontSize.tiny - 2,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  generateEthernetReceipt({
    required Subscription data,
    required String ipAddress,
    required int portNumber,
    required BuildContext context,
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    bytes += generator.text(
      AuthService.to.user.value!.businessFacility.name,
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        underline: false,
      ),
      linesAfter: 1,
    );
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
        text: 'TIN:',
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: AuthService.to.user.value!.businessFacility.tin ?? "N/A",
        width: 8,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Address:'.toUpperCase(),
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: AuthService.to.user.value!.businessFacility.address ?? "N/A",
        width: 8,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Date:'.toUpperCase(),
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
    ]);

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
        text: 'Member Name:'.toUpperCase(),
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: data.memberNames ?? "N/A",
        width: 8,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Member Phone:'.toUpperCase(),
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: data.memberPhoneNumber ?? "N/A",
        width: 8,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.hr();

    for (final plan in data.plans) {
      bytes += generator.row([
        PosColumn(
          width: 6,
          text: plan.name ?? "N/A",
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: plan.price.toString().formatAmount(),
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ]);
    }
    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(
        text: data.paymentMethod ?? "N/A",
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: data.plans
            .fold(0.0, (total, plan) => total + plan.price!)
            .toString()
            .formatAmount(),
        width: 8,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.hr();
    // Add QR Code
    bytes += generator.qrcode(
      data.memberRegistrationCode!,
      size: QRSize.size5,
      align: PosAlign.center,
    );
    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(
        text: "Served By",
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text:
            "${AuthService.to.user.value!.firstName} ${AuthService.to.user.value!.lastName}}",
        width: 8,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.cut();
    await printEscPosReceipt(
      receipt: bytes,
      ipAddress: ipAddress,
      port: portNumber,
      // ignore: use_build_context_synchronously
      context: context,
    );
  }

  ///[testEthernetEscPos] this allow printer on Ethernet to print test version
  Future<Either<String, String>> testEthernetEscPos({
    String ipAddress = "192.168.1.100",
    int port = 9100,
    required BuildContext context,
  }) async {
    PaperSize papersize = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final generator = Generator(papersize, profile);
    List<int> bytes = [];
    bytes += generator.text(
      '********************************',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );
    bytes += generator.text(
      'Raxii',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size1,
        width: PosTextSize.size1,
      ),
    );
    bytes += generator.feed(1);

    bytes += generator.text(
      'printer testing>>>>>>>>>printer connected successfully',
      styles: const PosStyles(
        align: PosAlign.left,
        bold: true,
        height: PosTextSize.size1,
        width: PosTextSize.size1,
      ),
    );
    bytes += generator.feed(1);
    bytes += generator.text(
      '********************************',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );
    bytes += generator.feed(3);
    bytes += generator.cut();

    final res = await printEscPosReceipt(
      receipt: bytes,
      ipAddress: ipAddress,
      port: port,
      // ignore: use_build_context_synchronously
      context: context,
    );

    return res;
  }

  /// Prints the receipt PDF document.
  Future<void> printReceipt({
    required Subscription data,
    required BuildContext context,
    int? portNumber,
    dynamic ipAddress,
  }) async {
    if (SettingService.to.selectedPrinterType.value == PrinterType.usb) {
      final pdfBytes = await generateReceiptPdf(data);
      await Printing.layoutPdf(
        format: PdfPageFormat.roll80,
        onLayout: (PdfPageFormat format) async => pdfBytes,
      );
    } else if (SettingService.to.selectedPrinterType.value ==
        PrinterType.ethernet) {
      generateEthernetReceipt(
          data: data,
          ipAddress: ipAddress,
          portNumber: portNumber!,
          context: context);
    }
  }
}

pw.Widget separator({
  pw.EdgeInsets margin = const pw.EdgeInsets.symmetric(vertical: 8),
  required PdfPageFormat pageFormat,
  bool isFooter = false,
}) {
  int count = (pageFormat.availableWidth ~/ 8) + 1;
  return pw.Row(
    children: List.generate(
      count,
      (index) {
        return pw.Row(children: [
          pw.Container(
            margin:
                isFooter ? const pw.EdgeInsets.only(top: 8, bottom: 0) : margin,
            height: 1,
            width: 5,
            color: PdfColor.fromHex("#484848"),
          ),
          if (index < count - 1)
            pw.SizedBox(
              width: 3,
            ),
        ]);
      },
    ),
  );
}

///[printEscPosReceipt] this is the main func helps connecting and printing on Ethernet Printer
Future<Either<String, String>> printEscPosReceipt({
  required String ipAddress,
  required int port,
  required List<int> receipt,
  required BuildContext context,
}) async {
  final printer = PrinterNetworkManager(ipAddress, port: port);
  PosPrintResult connect = await printer.connect();
  if (connect == PosPrintResult.success) {
    PosPrintResult printing = await printer.printTicket(receipt);
    printer.disconnect();
    return Right(printing.msg);
  } else {
    final toastification = Toastification();
    toastification.show(
      margin: const EdgeInsets.only(
        top: 50,
        right: 10,
      ),
      autoCloseDuration: const Duration(seconds: 20),
      // ignore: use_build_context_synchronously
      context: context,
      title: const Text("Error"),
      description: const Text(
          "Can't connect to the printer at the provided IP address and port."),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: false,
    );
    return Left(connect.msg);
  }
}
