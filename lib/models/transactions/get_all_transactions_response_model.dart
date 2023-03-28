import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/models/transaction_model.dart';

class GetAllTransactionsResponseModel {
  late List<TransactionModel> transactions;

  GetAllTransactionsResponseModel.fromJson(ResponseModel response) {
    var data = response.data;

    transactions = data['transactions'].map<TransactionModel>((trx) => TransactionModel.fromJson(trx)).toList(); 
  }

  Map<String, dynamic> toJson() {
    return {
      "transactions": transactions.map((trx) => trx.toJson()).toList()
    };
  }
}