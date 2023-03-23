import 'package:bantuin/models/bantuan_model.dart';
import 'package:bantuin/models/main_model/respose_model.dart';

class GetBantuanByUserModel {
  late List<BantuanModel> bantuans;

  GetBantuanByUserModel.fromJson(ResponseModel response) {
    var data = response.data;
    bantuans = data.map<BantuanModel>((bantuan) => BantuanModel.fromJson(bantuan)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "bantuans": bantuans.map((bantuan) => bantuan.toJson()).toList()
    };
  }
}