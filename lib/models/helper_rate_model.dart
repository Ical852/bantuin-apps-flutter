import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/models/helper_model.dart';
import 'package:bantuin/models/user_model.dart';

class HelperRateModel {
  late int id, userId, bantuanId, helperId, rating;
  late String message, createdAt, updatedAt;
  UserModel? user;
  BantuanModel? bantuan;
  HelperModel? helper;

  HelperRateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bantuanId = json['bantuan_id'];
    helperId = json['helper_id'];
    rating = json['rating'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] == null ? null : UserModel.fromJson(json['user']);
    bantuan = json['bantuan'] == null ? null : BantuanModel.fromJson(json['bantuan']);
    helper = json['helper'] == null ? null : HelperModel.fromJson(json['helper']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "bantuan_id": bantuanId,
      "helper_id": helperId,
      "rating": rating,
      "message": message,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "user": user == null ? null : user!.toJson(),
      "bantuan": bantuan == null ? null : bantuan!.toJson(),
      "helper": helper == null ? null : helper!.toJson(),
    };
  }
}