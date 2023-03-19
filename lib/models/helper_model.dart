class HelperModel {
  late int id, userId, helperBalance;
  late String status;

  HelperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    helperBalance = json['helper_balance'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "helper_balance": helperBalance,
      "status": status,
    };
  }
}