/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqdr_service_provider/screens/home/index.dart';
import 'package:tqdr_service_provider/states/app_provider.dart';
import 'package:tqdr_service_provider/states/invoice_provider.dart';
import 'package:tqdr_service_provider/states/service_provider_provider.dart';
import 'package:tqdr_service_provider/styles/button.dart';
import 'package:tqdr_service_provider/styles/text_field.dart';
import 'package:tqdr_service_provider/styles/theme.dart';
import 'package:tqdr_service_provider/widgets/drawer.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _accountKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var invoiceProvider = context.watch<InvoiceProvider>();
    var appProvider = context.watch<AppProvider>();
    var spProvider = context.watch<ServiceProviderProvider>();

    final TextEditingController _usernameController =
        TextEditingController(text: spProvider.username.toString());
    _usernameController.value = _usernameController.value.copyWith(
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: spProvider.username.toString().length ,
        ),
      ),
    );

    final TextEditingController _passController =
        TextEditingController(text: spProvider.password.toString());
    _passController.value = _passController.value.copyWith(
      selection: TextSelection.fromPosition(
        TextPosition(offset: spProvider.password.toString().length ),
      ),
    );

    return WillPopScope(
      onWillPop: () async => await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
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
          backgroundColor: appTheme.primaryColor,
          title: Text(
            'إعدادات الحساب',
            style: appTheme.textTheme.headline4,
          ),
          leading: const Text(''),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _accountKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                          style: buttonSubmit,
                          onPressed: () async {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: invoiceProvider.loading == 1
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Center(
                                      child: Text(
                                        ' اجمالي قيمة الإيصالات ${double.tryParse(invoiceProvider.totalInvoices.toString())!.toStringAsFixed(2)} ريال',
                                        style: buttonHomeText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                          style: buttonCancel,
                          onPressed: () async {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: invoiceProvider.loading == 1
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Center(
                                      child: Text(
                                        ' ربح مزود الخدمة ${double.tryParse(invoiceProvider.profitInvoices.toString())!.toStringAsFixed(2)}',
                                        style: buttonHomeText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  DropdownButton<BluetoothDevice>(
                    value: appProvider.selectedDevice,
                    hint: Text(
                      'اختر طابعة بلوتوث حرارية',
                      style: imageButtonText,
                    ),
                    onChanged: (device) {
                      appProvider.setSelectedDevice(device!);
                    },
                    items: appProvider.devices
                        .map((e) => DropdownMenuItem(
                              child: Text(
                                e.name!,
                                style: imageButtonText,
                              ),
                              value: e,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          appProvider.connectDevice(appProvider.selectedDevice!);
                        },
                        child: Text(
                          'توصيل',
                          style: unitText,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      TextButton(
                        onPressed: () {
                          appProvider.disConnectDevice();
                        },
                        child: Text(
                          'فصل',
                          style: yesDeleteButtonText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'اسم المستخدم',
                      suffixIcon: Icon(
                        Icons.person,
                        color: appTheme.primaryColor,
                      ),
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'هذا الحقل مطلوب!';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) => spProvider.setUserName(val),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'الرمز السري',
                      suffixIcon: Icon(
                        Icons.person,
                        color: appTheme.primaryColor,
                      ),
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'هذا الحقل مطلوب!';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) => spProvider.setPassword(val),
                  ),
                  const SizedBox(height: 10.0),
                  OutlinedButton(
                    onPressed: () async {
                      if (!_accountKey.currentState!.validate()) {
                        return;
                      } else {
                        await spProvider.setSP(
                            context,
                            spProvider.serviceProvider!.id.toString(),
                            spProvider.username!,
                            spProvider.password!);
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('username');
                        await prefs.remove('password');

                        Navigator.pushReplacementNamed(
                          context,
                          '/',
                        );
                      }
                    },
                    style: buttonSubmit.copyWith(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'تهيئة',
                          style: appTheme.textTheme.headline4,
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
