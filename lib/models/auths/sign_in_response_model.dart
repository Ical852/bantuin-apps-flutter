import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/models/user_model.dart';

class SignInResponseModel {
  late String accessToken, tokenType;
  late UserModel user;

  SignInResponseModel.fromJson(ResponseModel response) {
    var data = response.data;

    accessToken = data['access_token'];
    tokenType = data['token_type'];
    user = UserModel.fromJson(data['user']);
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": accessToken,
      "token_type": tokenType,
      "user": user,
    };
  }
}