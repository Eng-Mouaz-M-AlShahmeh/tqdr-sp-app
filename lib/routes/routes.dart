/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:tqdr_service_provider/screens/account/index.dart';
import 'package:tqdr_service_provider/screens/home/about.dart';
import 'package:tqdr_service_provider/screens/home/faqs.dart';
import 'package:tqdr_service_provider/screens/home/index.dart';
import 'package:tqdr_service_provider/screens/home/join.dart';
import 'package:tqdr_service_provider/screens/home/privacy.dart';
import 'package:tqdr_service_provider/screens/home/terms.dart';
import 'package:tqdr_service_provider/screens/invoice/index.dart';
import 'package:tqdr_service_provider/screens/invoice/show.dart';
import 'package:tqdr_service_provider/screens/account/login.dart';
import 'package:tqdr_service_provider/screens/splash/index.dart';
import 'package:tqdr_service_provider/screens/splash/success_splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/home': (context) => HomeScreen(),
  '/home/about': (context) => AboutScreen(),
  '/home/join': (context) => JoinScreen(),
  '/home/privacy': (context) => PrivacyScreen(),
  '/home/terms': (context) => TermsScreen(),
  '/home/faqs': (context) => FaqsScreen(),
  '/home/success_splash': (context) => const SuccessSplashScreen(),
  '/account': (context) => AccountScreen(),
  '/invoice': (context) => InvoiceScreen(),
  '/invoice/show': (context) => InvoiceShowScreen(),
};
