import 'package:bantuin/models/user_model.dart';

class HelperModel {
  late int id, userId, helperBalance;
  late String status;
  late UserModel? user;

  HelperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    helperBalance = json['helper_balance'];
    status = json['status'];
    user = json['user'] == null ? null : UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "helper_balance": helperBalance,
      "status": status,
      "user": user != null ? user!.toJson() : null,
    };
  }
}