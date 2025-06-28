import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:raxii_desktop/app/core/services/auth_service.dart';
import 'package:raxii_desktop/app/data/models/subscriptions.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/size.dart';

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

  /// Prints the receipt PDF document.
  Future<void> printReceipt(Subscription data) async {
    final pdfBytes = await generateReceiptPdf(data);
    await Printing.layoutPdf(
      format: PdfPageFormat.roll80,
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
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
