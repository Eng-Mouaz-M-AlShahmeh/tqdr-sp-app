/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:tqdr_service_provider/screens/account/login.dart';
import 'package:tqdr_service_provider/screens/home/index.dart';
import 'package:tqdr_service_provider/states/app_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AppProvider>().getDevices();
    context.read<AppProvider>().getPermission();
    context.read<AppProvider>().getSharedPreferences(context);

    return Scaffold(
      backgroundColor: const Color(0xff1f2835),
      body: Consumer<AppProvider>(
        builder: (context, sharedPref, child) {
          print('username: ${sharedPref.sharedUsername}');
          print('password: ${sharedPref.sharedPassword}');

          return AnimatedSplashScreen(
            duration: 1500,
            splash: Container(
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/logo-w.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            nextScreen: sharedPref.sharedUsername != null
                ? HomeScreen()
                : LoginScreen(),
            splashTransition: SplashTransition.fadeTransition,
            splashIconSize: 200,
            backgroundColor: const Color(0xff1f2835),
          );
        },
      ),
    );
  }
}
