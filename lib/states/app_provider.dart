/* Developed by: Eng Mouaz M. Al-Shahmeh */
// import 'dart:async';
import 'dart:io';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqdr_service_provider/states/service_provider_provider.dart';

class AppProvider extends ChangeNotifier {
  File? _qrImageFile;
  File? get qrImageFile => _qrImageFile;
  setQrImageFile(File val) async {
    _qrImageFile = val;
    notifyListeners();
  }

  List<BluetoothDevice> _devices = <BluetoothDevice>[];
  List<BluetoothDevice> get devices => _devices;

  BluetoothDevice? _selectedDevice;
  BluetoothDevice? get selectedDevice => _selectedDevice;

  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  getDevices() async {
    _devices = await printer.getBondedDevices();
    notifyListeners();
  }

  String? _sharedUsername;
  String? _sharedPassword;
  String? get sharedUsername => _sharedUsername;
  String? get sharedPassword => _sharedPassword;
  getSharedPreferences(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    _sharedUsername = prefs.getString('username');
    _sharedPassword = prefs.getString('password');
    if(_sharedUsername != null && _sharedPassword != null) {
      context.read<ServiceProviderProvider>().getSPCheck(context, _sharedUsername!, _sharedPassword!);
    }
    notifyListeners();
  }

  getPermission() async {
    if(! await Permission.bluetooth.isGranted) {
      await Permission.bluetooth.request();
    }
    if(! await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
    notifyListeners();
  }

  setSelectedDevice(BluetoothDevice device) {
    _selectedDevice = device;
    notifyListeners();
  }

  connectDevice(BluetoothDevice device) async {
    await BlueThermalPrinter.instance.connect(device);
    notifyListeners();
  }

  disConnectDevice() async {
    await BlueThermalPrinter.instance.disconnect();
    notifyListeners();
  }

  String? _pathImage;
  String? get pathImage => _pathImage;
  setPathImage(String val) async {
    _pathImage = val;
    notifyListeners();
  }

  String? _patPdf;
  String? get patPdf => _patPdf;
  setPathPDF(String val) async {
    _patPdf = val;
    notifyListeners();
  }

}
