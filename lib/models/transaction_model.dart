class TransactionModel {
  late int id, grossAmount, userId;
  late int? bantuanId;
  late String orderId, paymentUrl, transactionType, paymentMethod, status, createdAt, updatedAt;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossAmount = json['gross_amount'];
    userId = json['user_id'];
    bantuanId = json['bantuan_id'] == null ? null : json['bantuan_id'];
    orderId = json['order_id'];
    paymentUrl = json['payment_url'];
    transactionType = json['transaction_type'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "gross_amount": grossAmount,
      "user_id": userId,
      "bantuan_id": bantuanId,
      "order_id": orderId,
      "payment_url": paymentUrl,
      "transaction_type": transactionType,
      "payment_method": paymentMethod,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}