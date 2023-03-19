import 'package:bantuin/models/helper_model.dart';
import 'package:bantuin/models/user_device_model.dart';

class UserModel {
  late int id, balance;
  late String fullName, image, username, phoneNumber, email, role;
  late HelperModel? helper;
  late UserDeviceModel? userDevice;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    fullName = json['full_name'];
    image = json['image'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    role = json['role'];
    helper = json['helper'] != null ? HelperModel.fromJson(json['helper']) : json['helper'];
    userDevice = json['user_device'] != null ? UserDeviceModel.fromJson(json['user_device']) : json['user_device'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "balance": balance,
      "full_name": fullName,
      "image": image,
      "username": username,
      "phone_number": phoneNumber,
      "email": email,
      "role": role,
      "helper": helper,
      "user_device": userDevice,
    };
  }
}