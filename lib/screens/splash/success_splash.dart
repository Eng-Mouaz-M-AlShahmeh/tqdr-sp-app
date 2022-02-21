/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqdr_service_provider/states/app_provider.dart';
import 'package:tqdr_service_provider/states/invoice_provider.dart';
import 'package:tqdr_service_provider/styles/button.dart';
import 'package:tqdr_service_provider/styles/theme.dart';
import 'package:tqdr_service_provider/widgets/qr_image.dart';
import 'package:tqdr_service_provider/widgets/share_invoice.dart';

class SuccessSplashScreen extends StatelessWidget {
  const SuccessSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f2835),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: invoiceBGColor,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Container(
                    width: 350,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/thanks.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    context.watch<InvoiceProvider>().loading == 1
                        ? OutlinedButton(
                            onPressed: () async {},
                            style: buttonSubmit.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.orangeAccent[400]),
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
                                  .setLoadingState(1);
                              Future.delayed(const Duration(seconds: 1), () {
                                context
                                    .read<InvoiceProvider>()
                                    .setLoadingState(0);
                              });

                              await context.read<AppProvider>().setQrImageFile(
                                    await qrImageZaqat(context),
                                  );

                              await sharePdf(
                                context,
                                context
                                    .read<InvoiceProvider>()
                                    .printPDFInvoice!
                                    .amount
                                    .toString(),
                                context
                                    .read<InvoiceProvider>()
                                    .printPDFInvoice!
                                    .id
                                    .toString(),
                              );
                            },
                            style: buttonSubmit.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.orangeAccent[400]),
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
                    const SizedBox(width: 10.0),
                    OutlinedButton(
                      onPressed: () async {
                        context
                            .read<InvoiceProvider>()
                            .setAmountInvoiceNew('0');
                        await Navigator.pushReplacementNamed(
                          context,
                          '/home',
                        );
                      },
                      style: buttonSubmit.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orangeAccent[400]),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'الرئيسية',
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
        ],
      ),
    );
  }
}
