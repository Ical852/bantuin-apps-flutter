class UserDeviceModel {
  late int id, userId;
  late String email, deviceId;

  UserDeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    email = json['email'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "email": email,
      "device_id": deviceId,
    };
  }
}