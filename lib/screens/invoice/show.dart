/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqdr_service_provider/screens/invoice/index.dart';
import 'package:tqdr_service_provider/states/app_provider.dart';
import 'package:tqdr_service_provider/states/invoice_provider.dart';
import 'package:tqdr_service_provider/styles/button.dart';
import 'package:tqdr_service_provider/styles/text_field.dart';
import 'package:tqdr_service_provider/styles/theme.dart';
import 'package:tqdr_service_provider/widgets/drawer.dart';
import 'package:tqdr_service_provider/widgets/print_show.dart';
import 'package:tqdr_service_provider/widgets/qr_image.dart';
import 'package:tqdr_service_provider/widgets/share_invoice.dart';

class InvoiceShowScreen extends StatelessWidget {
  InvoiceShowScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var appProvider = context.watch<AppProvider>();
    var invoiceProvider = context.read<InvoiceProvider>();

    return WillPopScope(
      onWillPop: () async => await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => InvoiceScreen()),
        (route) => false,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height,
          child: const MainDrawer(),
        ),
        appBar: AppBar(
          leading: const Text(''),
          backgroundColor: appTheme.primaryColor,
          title: Text(
            'تفاصيل',
            style: appTheme.textTheme.headline4,
          ),
          actions: [
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/menu.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                enabled: false,
                initialValue:
                    invoiceProvider.selectedInvoice!.amount.toString(),
                decoration: textInputDecoration.copyWith(
                  labelText: 'المبلغ',
                  suffixIcon: Icon(
                    Icons.attach_money,
                    color: appTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                enabled: false,
                initialValue: invoiceProvider.selectedInvoice!.id.toString(),
                decoration: textInputDecoration.copyWith(
                  labelText: 'رقم الإيصال',
                  suffixIcon: Icon(
                    Icons.card_giftcard_rounded,
                    color: appTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  context.watch<InvoiceProvider>().loading == 1
                      ? OutlinedButton(
                          onPressed: () async {},
                          style: buttonSubmit.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: () async {
                            context.read<InvoiceProvider>().setLoadingState(1);

                            await Future.delayed(const Duration(seconds: 3),
                                () {
                              context
                                  .read<InvoiceProvider>()
                                  .setLoadingState(0);
                            });

                            await appProvider.setQrImageFile(
                              await qrImageZaqatSelected(context),
                            );

                            await printPdfSmallShow(
                              context,
                              invoiceProvider.selectedInvoice!.amount
                                  .toString(),
                              invoiceProvider.selectedInvoice!.id.toString(),
                            );
                          },
                          style: buttonSubmit.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.print,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'طباعة',
                                    style: appTheme.textTheme.headline4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(width: 10.0),
                  context.watch<InvoiceProvider>().loadingSharing == 1
                      ? OutlinedButton(
                          onPressed: () async {},
                          style: buttonSubmit.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo[900]),
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: () async {
                            context
                                .read<InvoiceProvider>()
                                .setLoadingStateShare(1);
                            await Future.delayed(const Duration(seconds: 3),
                                () {
                              context
                                  .read<InvoiceProvider>()
                                  .setLoadingStateShare(0);
                            });
                            await appProvider.setQrImageFile(
                              await qrImageZaqatSelected(context),
                            );
                            await sharePdf(
                              context,
                              invoiceProvider.selectedInvoice!.amount
                                  .toString(),
                              invoiceProvider.selectedInvoice!.id.toString(),
                            );
                          },
                          style: buttonSubmit.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo[900]),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'مشاركة',
                                    style: appTheme.textTheme.headline4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
