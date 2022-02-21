/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tqdr_service_provider/states/app_provider.dart';
import 'package:tqdr_service_provider/states/invoice_provider.dart';
import 'package:tqdr_service_provider/states/service_provider_provider.dart';
import 'package:tqdr_service_provider/styles/button.dart';
import 'package:tqdr_service_provider/styles/text_field.dart';
import 'package:tqdr_service_provider/styles/theme.dart';
import 'package:tqdr_service_provider/widgets/close_app_modal.dart';
import 'package:tqdr_service_provider/widgets/drawer.dart';
import 'package:tqdr_service_provider/widgets/greater_amount.dart';
import 'package:tqdr_service_provider/widgets/print_small.dart';
import 'package:tqdr_service_provider/widgets/qr_image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _newInvoiceKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var invoiceProvider = context.watch<InvoiceProvider>();
    final TextEditingController _amountController = TextEditingController(
        text: invoiceProvider.amountInvoiceNew == null
            ? '0'
            : invoiceProvider.amountInvoiceNew.toString());
    _amountController.value = _amountController.value.copyWith(
      selection: TextSelection.fromPosition(
        TextPosition(
            offset: invoiceProvider.amountInvoiceNew.toString().length - 2),
      ),
    );

    return WillPopScope(
      onWillPop: () => onCloseApp(context),
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height,
          child: const MainDrawer(),
        ),
        appBar: AppBar(
          backgroundColor: appTheme.primaryColor,
          title: Text(
            'مزود الخدمة',
            style: appTheme.textTheme.headline4,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/logo-w.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
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
          child: Form(
            key: _newInvoiceKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Consumer<InvoiceProvider>(
                      builder: (context, invoice, child) {
                        return TextFormField(
                            controller: _amountController,
                            showCursor: true,
                            readOnly: true,
                            style: const TextStyle(fontSize: 28),
                            decoration: textInputDecoration.copyWith(
                              labelText: 'المبلغ',
                              suffixIcon: Icon(
                                Icons.monetization_on_outlined,
                                color: appTheme.primaryColor,
                              ),
                            ),
                            onChanged: (val) {
                              invoiceProvider.setAmountInvoiceNew(val);
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return 'هذا الحقل مطلوب!';
                              } else {
                                return null;
                              }
                            });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                SystemSound.play(SystemSoundType.click);

                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('1');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}1');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '1',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('2');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}2');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '2',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('3');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}3');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '3',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('4');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}4');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '4',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('5');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}5');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '5',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('6');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}6');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '6',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('7');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}7');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '7',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('8');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}8');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '8',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('9');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}9');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '9',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('0');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}0');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '0',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                if (invoiceProvider.amountInvoiceNew == null ||
                                    invoiceProvider.amountInvoiceNew == '0') {
                                  invoiceProvider.setAmountInvoiceNew('0');
                                } else {
                                  invoiceProvider.setAmountInvoiceNew(
                                      '${invoiceProvider.amountInvoiceNew}00');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Text(
                                    '00',
                                    style: buttonCalc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextButton(
                              style: buttonSubmit,
                              onPressed: () {
                                invoiceProvider.setAmountInvoiceNew('0');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/images/clear.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  invoiceProvider.loading == 1
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
                            if (!_newInvoiceKey.currentState!.validate()) {
                              return;
                            } else if (int.tryParse(
                                    invoiceProvider.amountInvoiceNew!)! >
                                5000) {
                              onErrorAmount(context,
                                  'عذراً مبلغ الطلب أكثر من 5000 ريال!');
                              return;
                            } else if (int.tryParse(
                                    invoiceProvider.amountInvoiceNew!)! <
                                6) {
                              onErrorAmount(
                                  context, 'عذراً مبلغ الطلب أقل من 5 ريال!');
                              return;
                            } else {
                              onSubmitAmount(context,
                                  'هل تريد تأكيد دفع مبلغ ${invoiceProvider.amountInvoiceNew} ؟ ');
                            }
                          },
                          style: buttonSubmit.copyWith(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.orangeAccent[400]),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'تأكيد',
                                    style: appTheme.textTheme.headline4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

done(BuildContext context) async {
  var invoiceProvider = context.read<InvoiceProvider>();
  var spProvider = context.read<ServiceProviderProvider>();

   invoiceProvider.setAmountInvoiceNew(
      '${int.tryParse(invoiceProvider.amountInvoiceNew!)! - 5}');
   invoiceProvider.addInvoice(
    context,
    invoiceProvider.amountInvoiceNew!,
    invoiceProvider.amountInvoiceNew!,
    '0',
    '${spProvider.serviceProvider!.id}',
  );

  await context.read<AppProvider>().setQrImageFile(
        await qrImageZaqat(context),
  );

  await Future.delayed(const Duration(seconds: 2), () {
    printPdfSmall(
      context,
      invoiceProvider.printPDFInvoice!.amount.toString(),
      invoiceProvider.printPDFInvoice!.id.toString(),
    );
  });

  // Navigator.of(context).pop(false);

}
