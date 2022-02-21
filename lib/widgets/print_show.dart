/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'dart:async';
import 'dart:io';
import 'package:android_external_storage/android_external_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:tqdr_service_provider/states/app_provider.dart';
import 'package:tqdr_service_provider/states/invoice_provider.dart';

Future<void> printPdfSmallShow(
    BuildContext context, String amount, String id) async {
  var appProvider = context.read<AppProvider>();

  final pw.Document pdf = pw.Document();
  var arabicFont = pw.Font.ttf(await rootBundle.load('assets/fonts/Arial.ttf'));

  var dataImage = await rootBundle.load('assets/images/logo.png');
  var logo = dataImage.buffer
      .asUint8List(dataImage.offsetInBytes, dataImage.lengthInBytes);

  var dataImage2 = await rootBundle.load('assets/images/zarqash.png');
  var zarqash = dataImage2.buffer
      .asUint8List(dataImage2.offsetInBytes, dataImage2.lengthInBytes);

  var dataImage3 = await rootBundle.load('assets/images/email.png');
  var email = dataImage3.buffer
      .asUint8List(dataImage3.offsetInBytes, dataImage3.lengthInBytes);

  var dataImage5 = await rootBundle.load('assets/images/twitter.png');
  var twitter = dataImage5.buffer
      .asUint8List(dataImage5.offsetInBytes, dataImage5.lengthInBytes);

  var dataImage6 = await rootBundle.load('assets/images/facebook.png');
  var facebook = dataImage6.buffer
      .asUint8List(dataImage6.offsetInBytes, dataImage6.lengthInBytes);

  var dataImage7 = await rootBundle.load('assets/images/snapchat.png');
  var snapchat = dataImage7.buffer
      .asUint8List(dataImage7.offsetInBytes, dataImage7.lengthInBytes);

  var dataImage8 = await rootBundle.load('assets/images/instagram.png');
  var instagram = dataImage8.buffer
      .asUint8List(dataImage8.offsetInBytes, dataImage8.lengthInBytes);

  var dataImage9 = await rootBundle.load('assets/images/support.png');
  var support = dataImage9.buffer
      .asUint8List(dataImage9.offsetInBytes, dataImage9.lengthInBytes);

  final fileQr = appProvider.qrImageFile; // File
  final bytesQr = await fileQr!.readAsBytes(); // Unit8List
  var qrImage =
      bytesQr.buffer.asUint8List(bytesQr.offsetInBytes, bytesQr.lengthInBytes);

  // inch = 72.0  -- mm = inch / 25.4  -- pos w/h = 40.0 * 57

  pdf.addPage(pw.MultiPage(
      margin: const pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: const PdfPageFormat(
          40.0 * (72.0 / 25.4), 57.0 * (72.0 / 25.4),
          marginAll: 8.0 * (72.0 / 25.4)),
      textDirection: pw.TextDirection.rtl,
      build: (context) {
        return [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Image(pw.MemoryImage(logo),
                  width: 40, height: 20, fit: pw.BoxFit.fill),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Image(
                  pw.MemoryImage(zarqash),
                  width: 100,
                  height: 20,
                  fit: pw.BoxFit.fill,
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  '  شكراً لاستخدامك تقدر ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 5,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: pw.Text(
                  ' رقم الطلب: $id ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' المبلغ المطلوب: $amount ريال ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' سعر الخدمة 5 ريال تخصم مباشرة من المبلغ ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
          pw.Divider(
            color: PdfColor.fromHex('#000000'),
            height: 3,
            thickness: 0.2,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 1, 0, 0),
                child: pw.Text(
                  ' كيف تستخدم تقدر ؟ ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' -1 زيارة منصة تقدر www.tqdr.com.sa ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' -2 تعبئة البيانات ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' -3 تصلك رسالة نصية تؤكد تنفيذ طلبك ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' * بإمكانك الدفع من خلال موقع شريك تقدر ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: pw.Text(
                  ' بإضافة رقم الطلب والجوال. ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
          pw.Divider(
            color: PdfColor.fromHex('#000000'),
            height: 5,
            thickness: 0.2,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' الدعم الفني ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 7,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Image(pw.MemoryImage(support),
                    width: 13, height: 13, fit: pw.BoxFit.fill),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' +966 566 29 3256 ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 7,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: pw.Text(
                  ' *************************** ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: pw.Text(
                  ' info@tqdr.com.sa ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 7,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: pw.Image(pw.MemoryImage(email),
                    width: 11, height: 11, fit: pw.BoxFit.fill),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(2, 5, 2, 0),
                child: pw.Image(pw.MemoryImage(twitter),
                    width: 11, height: 11, fit: pw.BoxFit.fill),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(2, 5, 2, 0),
                child: pw.Image(pw.MemoryImage(facebook),
                    width: 11, height: 11, fit: pw.BoxFit.fill),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(2, 5, 2, 0),
                child: pw.Image(pw.MemoryImage(snapchat),
                    width: 11, height: 11, fit: pw.BoxFit.fill),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(2, 5, 2, 0),
                child: pw.Image(pw.MemoryImage(instagram),
                    width: 11, height: 11, fit: pw.BoxFit.fill),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: pw.Text(
                  ' @tqdrpaysa ',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          pw.Divider(
            color: PdfColor.fromHex('#000000'),
            height: 2,
            thickness: 0.2,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: pw.Image(
                  pw.MemoryImage(qrImage),
                  width: 50,
                  height: 50,
                  fit: pw.BoxFit.fill,
                ),
              ),
            ],
          ),
        ];
      }));

  final String? path =
      await AndroidExternalStorage.getExternalStoragePublicDirectory(
          DirType.downloadDirectory);
  final String fullPath = '$path/tqdr_invoice.pdf';
  final File file = File(fullPath);
  await file.writeAsBytes(await pdf.save());
  appProvider.setPathPDF(fullPath);

  context.read<InvoiceProvider>().setLoadingState(0);

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => await pdf.save(),
  );

}
