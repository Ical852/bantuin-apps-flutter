import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/models/notification_model.dart';

class GetAllNotifResponse {
  late List<NotificationModel> notifications;

  GetAllNotifResponse.fromJson(ResponseModel response) {
    var data = response.data;
    notifications = data['notifications'].map<NotificationModel>((notif) => NotificationModel.fromJson(notif)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "notifications": notifications
    };
  }
}