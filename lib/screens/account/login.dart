/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqdr_service_provider/states/service_provider_provider.dart';
import 'package:tqdr_service_provider/styles/button.dart';
import 'package:tqdr_service_provider/styles/text_field.dart';
import 'package:tqdr_service_provider/styles/theme.dart';
import 'package:tqdr_service_provider/widgets/close_app_modal.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var spProvider = context.watch<ServiceProviderProvider>();

    return WillPopScope(
      onWillPop: () => onCloseApp(context),
      child: Scaffold(
        backgroundColor: bgColorRegular,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 40.0),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/images/logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
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
                                obscureText: true,
                                decoration: textInputDecoration.copyWith(
                                  labelText: 'الرمز السري',
                                  suffixIcon: Icon(
                                    Icons.lock,
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
                              spProvider.loading == 1
                                  ? OutlinedButton(
                                      onPressed: () async {},
                                      style: buttonSubmit.copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.indigo[900]),
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
                                        if (!_loginKey.currentState!
                                            .validate()) {
                                          return;
                                        } else {
                                          await spProvider.getSPCheck(
                                              context,
                                              spProvider.username!,
                                              spProvider.password!);
                                        }
                                      },
                                      style: buttonSubmit.copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.indigo[900]),
                                      ),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'تسجيل الدخول',
                                          style: appTheme.textTheme.headline4,
                                        ),
                                      )),
                                    ),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
