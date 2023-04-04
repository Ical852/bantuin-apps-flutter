import 'package:bantuin/models/chat_model.dart';
import 'package:bantuin/models/main_model/respose_model.dart';

class GetAllChatResponseModel {
  late List<ChatModel> chats;

  GetAllChatResponseModel.fromJson(ResponseModel response) {
    var data = response.data;

    chats = data['chat'].map<ChatModel>((chat) => ChatModel.fromJson(chat)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "chats": chats.map((chat) => chat.toJson()).toList()
    };
  }
}