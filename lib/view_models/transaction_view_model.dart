import 'dart:math';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/transaction_model.dart';
import 'package:bantuin/models/transactions/get_all_transactions_response_model.dart';
import 'package:bantuin/services/transaction_service.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:flutter/widgets.dart';

class TransactionViewModel {
  late BuildContext context;
  late TransactionService transactionService;
  late UserViewModel userVm;
  late String token;

  TransactionViewModel(BuildContext context) {
    this.transactionService = TransactionService(context);
    this.userVm = UserViewModel(context);
    this.token = this.userVm.getToken();
    this.context = context;
  }

  Future<String> topUp({
    required int grossAmount,
  }) async {
    var response = await transactionService.createTransaction(
      bantuanId: 0,
      orderId: (Random().nextInt(900) + 10).toString(),
      grossAmount: grossAmount,
      transactionType: "topup",
      paymentMethod: 'midtrans',
      token: token
    );

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return "";
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Top Up Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return "";
    }

    this.userVm.fetch();
    var transactionResponse = TransactionModel.fromJson(response.data['transaction']);
    return transactionResponse.paymentUrl;
  }

  Future<List<TransactionModel>> getTransactions() async {
    var response = await transactionService.getTransactions(token: token);

    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Transactions Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return [];
    }

    var transactionsResponse = GetAllTransactionsResponseModel.fromJson(response);
    return transactionsResponse.transactions;
  }
}