import 'package:bantuin/models/bantuan_category_model.dart';
import 'package:bantuin/models/user_model.dart';

class BantuanModel {
  late int id, price, userId, categoryId;
  late String image, title, desc, location, payType, status, createdAt, updatedAt;
  late BantuanCategoryModel? bantuanCategory;
  late UserModel? user;

  BantuanModel();

  BantuanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'].runtimeType == String ? int.parse(json['price']) : json['price'];
    userId =  json['user_id'].runtimeType == String ? int.parse( json['user_id']) :  json['user_id'];
    categoryId = json['category_id'].runtimeType == String ? int.parse( json['category_id']) :  json['category_id'];
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    location = json['location'];
    payType = json['pay_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bantuanCategory = json['bantuan_category'] == null ? null : BantuanCategoryModel.fromJson(json['bantuan_category']);
    user = json['user'] == null ? null :  UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "price": price,
      "user_id": userId,
      "category_id": categoryId,
      "image": image,
      "title": title,
      "desc": desc,
      "location": location,
      "pay_type": payType,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "bantuan_category": bantuanCategory!.toJson(),
      "user": user!.toJson(),
    };
  }
}