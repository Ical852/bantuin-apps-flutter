import 'package:bantuin/models/helper_model.dart';
import 'package:bantuin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  late int id, userId, helperId;
  late String createdAt, updatedAt;
  late UserModel? user;
  late HelperModel? helper;
  late String? lastChat = null;
  late int? totalUnreaded = null;
  late String? lastHour = null;

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    helperId = json['helper_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    helper = json['helper'] != null ? HelperModel.fromJson(json['helper']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Future setLastChat(String groupId) async {
    await FirebaseFirestore.instance.collection(groupId).orderBy("date", descending: true)
      .limit(1)
      .get()
      .then((querySnapshot) {
        if (querySnapshot.size > 0) {
          lastChat = querySnapshot.docs.first.data()['message'];
          var time = DateTime.fromMillisecondsSinceEpoch(querySnapshot.docs.first.data()['date'].seconds * 1000);
          lastHour = '${time.hour}:${time.minute}';
        } else {
          lastChat = null;
        }
      }
    );
  }

  Future setTotalUnreaded(String groupId, String id) async {
    await FirebaseFirestore.instance.collection(groupId)
      .where('userId', isEqualTo: id)
      .where('isRead', isEqualTo: false)
      .get()
      .then((value) {
        totalUnreaded = value.size;
      }
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "helper_id": helperId,
      "user": user != null ? user!.toJson() : null,
      "helper": helper != null ? helper!.toJson() : null,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}