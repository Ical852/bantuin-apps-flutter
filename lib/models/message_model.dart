import 'package:flutter/src/widgets/text.dart';

class MessageModel {
  late int groupId;
  late int userId;
  late String date;
  late String message;

  MessageModel({
    required this.groupId,
    required this.userId,
    required this.date,
    required this.message
  });

  MessageModel.fromJson(dynamic json) {
    this.groupId = json['groupId'];
    this.userId = json['userId'];
    this.date = json['date'];
    this.message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'userId': userId,
      'date': date,
      'message': message
    };
  }
}