/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Api {
  String baseURL = 'https://tqdr.com.sa/api';
  String key =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdHFkci5jb20uc2FcL2FwaVwvbG9naW4iLCJpYXQiOjE2Mzc3NjcyODgsImV4cCI6MTYzNzc2OTA4OCwibmJmIjoxNjM3NzY3Mjg4LCJqdGkiOiJ6azRLYnJ3T0FRTUdicnNPIiwic3ViIjoxMiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.jrj22YPlVZKR6l04IkzgX67ZuaQN50GGiLCeUtwzMtA';
  Future<dynamic> getAllInvoices(
    BuildContext context,
    String id,
  ) async {
    Uri? url = Uri.tryParse('$baseURL/invoice');
    var response = await http.post(url!, headers: {}, body: {
      'apikey': key,
      'id': id,
    });

    if (response.statusCode == 200) {
      var jsonx = json.decode(response.body);
      return jsonx['data'];
    } else {
      await Fluttertoast.showToast(
        msg: 'هناك خطأ راجع الدعم الفني',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      return null;
    }
  }

  Future<dynamic> addInvoice(
    BuildContext context,
    String amount,
    String remainingAmount,
    String isPaid,
    String serviceProviderId,
  ) async {
    Uri? url = Uri.tryParse('$baseURL/invoice/create');
    var response = await http.post(
      url!,
      body: {
        'apikey': key,
        'amount': amount.toString(),
        'remaining_amount': remainingAmount.toString(),
        'is_paid': isPaid.toString(),
        'service_provider_id': serviceProviderId.toString(),
      },
    );

    if (response.statusCode == 200) {
      var jsonx = json.decode(response.body);
      await Fluttertoast.showToast(
          msg: 'تم إضافة إيصال بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
      return jsonx['data'];
    } else {
      await Fluttertoast.showToast(
        msg: 'هناك خطأ راجع الدعم الفني',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      return null;
    }
  }

  Future<dynamic> getServiceProviderInfo(
    BuildContext context,
    String username,
    String password,
  ) async {
    Uri? url = Uri.tryParse('$baseURL/serviceprovider/checklogin');
    var response = await http.post(url!, headers: {}, body: {
      'apikey': key,
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonx = json.decode(response.body);
      if (jsonx['data']['active'] == 1) {
        await Fluttertoast.showToast(
            msg: 'تم تسجيل الدخول بنجاح',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0);
        return jsonx['data'];
      } else {
        await Fluttertoast.showToast(
            msg: 'تم حظر الحساب برجاء التواصل مع الدعم الفني!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
        return null;
      }
    } else if (response.statusCode == 400) {
      await Fluttertoast.showToast(
          msg: 'الرمز السري غير صحيح!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
      return null;
    } else {
      await Fluttertoast.showToast(
        msg: 'هناك خطأ راجع الدعم الفني',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      return null;
    }
  }

  Future<dynamic> setServiceProviderInfo(
    BuildContext context,
    String id,
    String username,
    String password,
  ) async {
    Uri? url = Uri.tryParse('$baseURL/serviceprovider/updatesp');
    var response = await http.post(url!, headers: {}, body: {
      'apikey': key,
      'id': id,
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'تم تهيئة المعلومات بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
      return null;
    } else if (response.statusCode == 404) {
      await Fluttertoast.showToast(
          msg: 'عذراً الحساب غير موجود!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
      return null;
    } else {
      await Fluttertoast.showToast(
        msg: 'هناك خطأ راجع الدعم الفني',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      return null;
    }
  }
}
