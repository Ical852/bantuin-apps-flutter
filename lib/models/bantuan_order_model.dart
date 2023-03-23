import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/models/helper_model.dart';

class BantuanOrderModel {
  late int id, userId, bantuanId, helperId;
  late String status, createdAt, updatedAt;
  late String? reason; 
  late HelperModel helper;
  late BantuanModel bantuan;

  BantuanOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bantuanId = json['bantuan_id'];
    helperId = json['helper_id'];
    status = json['status'];
    reason = json['reason'] != null ? json['reason'] : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    helper = HelperModel.fromJson(json['helper']);
    bantuan = BantuanModel.fromJson(json['bantuan']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "bantuan_id": bantuanId,
      "helper_id": helperId,
      "status": status,
      "reason": reason,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "helper": helper.toJson(),
      "bantuan": bantuan.toJson(),
    };
  }
}