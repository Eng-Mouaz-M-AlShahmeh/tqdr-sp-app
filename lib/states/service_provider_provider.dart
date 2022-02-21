/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqdr_service_provider/models/service_provider.dart';
import 'package:tqdr_service_provider/utils/api.dart';

class ServiceProviderProvider extends ChangeNotifier {
  int _loading = 0;
  int get loading => _loading;
  setLoadingState(int val) {
    _loading = val;
    notifyListeners();
  }

  String? _username;
  String? get username => _username;
  setUserName(String val) {
    _username = val;
    notifyListeners();
  }

  String? _password;
  String? get password => _password;
  setPassword(String val) {
    _password = val;
    notifyListeners();
  }

  ServiceProviderModel? _serviceProvider;
  ServiceProviderModel? get serviceProvider => _serviceProvider;

  getSPCheck (
    BuildContext context,
    String username,
    String password,
  ) {
    var pass = password;
    var usernamee = username;
    setLoadingState(1);
    Future.delayed(const Duration(milliseconds: 0), () {
      Api()
          .getServiceProviderInfo(
        context,
        username,
        password,
      )
          .then((value) async{
        if (value == null) {
          setLoadingState(0);
          return;
        } else {
          setLoadingState(0);
          _serviceProvider = ServiceProviderModel.fromJson(value);

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', usernamee);
          await prefs.setString('password', pass);
          setUserName(usernamee);
          setPassword(pass);

          // final String? username = prefs.getString('username');
          // final String? password = prefs.getString('password');

          Navigator.pushReplacementNamed(
            context,
            '/home',
          );
          notifyListeners();
          return;
        }
      });
    });
  }

  setSP(
    BuildContext context,
    String id,
    String username,
    String password,
  ) {
    Future.delayed(const Duration(milliseconds: 0), () {
      Api()
          .setServiceProviderInfo(
            context,
            id,
            username,
            password,
          )
          .then((value) {});
    });
  }
}
