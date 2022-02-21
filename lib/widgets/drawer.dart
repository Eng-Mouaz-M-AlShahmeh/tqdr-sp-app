/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
// import 'package:localstore/localstore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqdr_service_provider/states/app_provider.dart';
import 'package:tqdr_service_provider/states/invoice_provider.dart';
import 'package:tqdr_service_provider/states/service_provider_provider.dart';
import 'package:tqdr_service_provider/styles/theme.dart';
import 'package:tqdr_service_provider/widgets/home_buttons_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xfff0ad4e),
                width: 3.0,
              ),
            ),
            color: Color(0xff0e307e),
          ),
        ),
        //backgroundColor: const Color(0xff0e307e),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/logo-w.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        leading: const Text(''),
        actions: [
          InkWell(
            onTap: () {
              _launchWhatsApp();
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/whatsappw.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                itemCount: homeButtonsListDrawer.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (homeButtonsListDrawer[index]['screenRoute'] ==
                          '/invoice') {
                        context.read<InvoiceProvider>().getInvoicesList(
                              context,
                              context
                                  .read<ServiceProviderProvider>()
                                  .serviceProvider!
                                  .id
                                  .toString(),
                            );
                      }

                      if (homeButtonsListDrawer[index]['screenRoute'] ==
                          '/account') {
                        context.read<AppProvider>().getDevices();

                        context.read<AppProvider>().getPermission();

                        context.read<InvoiceProvider>().getInvoicesList(
                              context,
                              context
                                  .read<ServiceProviderProvider>()
                                  .serviceProvider!
                                  .id
                                  .toString(),
                            );
                      }

                      Navigator.pushReplacementNamed(
                        context,
                        '${homeButtonsListDrawer[index]['screenRoute']}',
                      );
                    },
                    title: Text(
                      '${homeButtonsListDrawer[index]["buttonTitle"]}',
                      style: appTheme.textTheme.headline3,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage(
                              'assets/images/${homeButtonsListDrawer[index]['iconName']}'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('username');
                await prefs.remove('password');

                Navigator.pushReplacementNamed(
                  context,
                  '/',
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/logout.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Text(
                    'تسجيل خروج',
                    style: yesDeleteButtonText,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'v 1.0.0',
                  style: tableHeaderSub,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 40,
        //color: const Color(0xff0e307e),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xfff0ad4e),
              width: 3.0,
            ),
          ),
          color: Color(0xff0e307e),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _launchURLFacebook();
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/facebookw.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _launchURLTwitter();
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/twitterw.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _launchURLInstagram();
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              ExactAssetImage('assets/images/instagramw.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _launchURLFacebook() async {
  const url = 'https://www.facebook.com/tqdrpaysa.tqdr';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchURLTwitter() async {
  const url = 'https://twitter.com/tqdrpaysa';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchURLInstagram() async {
  const url = 'https://instagram.com/tqdrpaysa';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchWhatsApp() async {
  var link = const WhatsAppUnilink(
    phoneNumber: '+966566293256',
    text: 'تطبيق تقدر - الدعم الفني',
  );
  await launch('$link');
}
