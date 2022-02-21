/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqdr_service_provider/models/invoice.dart';
import 'package:tqdr_service_provider/states/service_provider_provider.dart';
import 'package:tqdr_service_provider/utils/api.dart';

class InvoiceProvider extends ChangeNotifier {
  final List<InvoiceModel> _invoices = [];
  List<InvoiceModel> get invoices => _invoices;
  List _invoicesData = [];
  int _loading = 0;
  int get loading => _loading;
  setLoadingState(int val) {
    _loading = val;
    notifyListeners();
  }

  int _loadingSharing = 0;
  int get loadingSharing => _loadingSharing;
  setLoadingStateShare(int val) {
    _loadingSharing = val;
    notifyListeners();
  }

  getInvoicesList(
    BuildContext context,
    String id,
  ) {
    var profitFixedAmount = context
        .read<ServiceProviderProvider>()
        .serviceProvider!
        .profitFixedAmount;
    setLoadingState(1);
    Future.delayed(const Duration(milliseconds: 0), () {
      _totalInvoices = 0.0;
      _profitInvoices = 0.0;
      _invoices.clear();
      Api()
          .getAllInvoices(
        context,
        id,
      )
          .then((value) {
        if (value != null) {
          setLoadingState(0);
          _invoicesData = value;
          for (var e in _invoicesData) {
            _invoices.add(InvoiceModel.fromJson(e));
            _totalInvoices =
                _totalInvoices! + num.tryParse(e['amount'].toString())!;
            _profitInvoices =
                _profitInvoices! + num.tryParse(profitFixedAmount.toString())!;
          }
          notifyListeners();
          return;
        } else {
          setLoadingState(1);
          return;
        }
      });
    });
  }

  double? _totalInvoices;
  double? get totalInvoices => _totalInvoices;

  double? _profitInvoices;
  double? get profitInvoices => _profitInvoices;

  int? _idInvoice;
  int? get idInvoice => _idInvoice;
  InvoiceModel? _selectedInvoice;
  InvoiceModel? get selectedInvoice => _selectedInvoice;
  setIdInvoice(int id) {
    _idInvoice = id;
    for (var element in _invoices) {
      if (element.id == _idInvoice) {
        _selectedInvoice = InvoiceModel(
          id: element.id,
          amount: element.amount,
          remainingAmount: element.remainingAmount,
          isPaid: element.isPaid,
          status: element.status,
          serviceProviderId: element.serviceProviderId,
          createdAt: element.createdAt,
          updatedAt: element.updatedAt,
        );
      }
    }
    notifyListeners();
  }

  InvoiceModel? _printPDFInvoice;
  InvoiceModel? get printPDFInvoice => _printPDFInvoice;
  addInvoice(
    BuildContext context,
    String amount,
    String remainingAmount,
    String isPaid,
    String serviceProviderId,
  ) {
    setLoadingState(1);
    Future.delayed(const Duration(milliseconds: 0), () {
      Api()
          .addInvoice(
        context,
        amount,
        remainingAmount,
        isPaid,
        serviceProviderId,
      )
          .then((value) {
        if (value != null) {
          setLoadingState(0);
          _printPDFInvoice = InvoiceModel.fromJson(value);
          notifyListeners();
          return;
        } else if (value == null) {
          setLoadingState(0);
          return;
        }
      });
    });
  }

  String? _amountInvoiceNew;
  String? get amountInvoiceNew => _amountInvoiceNew;
  setAmountInvoiceNew(String amount) {
    _amountInvoiceNew = amount;
    notifyListeners();
  }
}
