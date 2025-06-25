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
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    AuthService.to.user.value!.businessFacility.name,
                    style: pw.TextStyle(
                      fontSize: AppFontSize.tiny - 2,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "Address: ${AuthService.to.user.value!.businessFacility.address}",
                    style: pw.TextStyle(
                      fontSize: AppFontSize.tiny - 2,
                    ),
                  ),
                  pw.Text(
                    "Tin: ${AuthService.to.user.value!.businessFacility.tin!}",
                    style: pw.TextStyle(
                      fontSize: AppFontSize.tiny - 2,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: AppSpaceSize.defaultS),
              pw.Text(
                'Member Name: ${data.memberNames}',
                style: pw.TextStyle(
                  fontSize: AppFontSize.tiny - 2,
                ),
              ),
              pw.Text(
                'Member Phone: ${data.memberPhoneNumber}',
                style: pw.TextStyle(
                  fontSize: AppFontSize.tiny - 2,
                ),
              ),
              pw.SizedBox(height: AppSpaceSize.defaultS),
              pw.Row(
                  // crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'Receipt',
                      style: pw.TextStyle(
                          fontSize: AppFontSize.tiny - 2,
                          fontWeight: pw.FontWeight.bold),
                    ),
                  ]),
              pw.SizedBox(height: AppSpaceSize.defaultS),
              pw.Column(
                children: [
                  pw.Row(
                    children: [
                      pw.Text(
                        'Plans',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: AppFontSize.tiny - 2,
                        ),
                      ),
                    ],
                  ),
                  ...data.plans.map((plan) => pw.Row(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(plan.name!),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child:
                                pw.Text(plan.price.toString().formatAmount()),
                          ),
                        ],
                      )),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Total: ',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text(data.plans
                      .fold(0.0, (total, plan) => total + plan.price!)
                      .toString()
                      .formatAmount()),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Text('Payment Method: ${data.paymentMethod}'),
              pw.SizedBox(height: 16),
              pw.Text('Thank you for your business!',
                  style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
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
