class NotificationModel {
  late int id, userId;
  late String title, message, createdAt, updatedAt;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "title": title,
      "message": message,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}