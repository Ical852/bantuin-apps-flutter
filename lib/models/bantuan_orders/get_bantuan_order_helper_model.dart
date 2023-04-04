import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/models/main_model/respose_model.dart';

class GetBantuanOrderHelperResponseModel {
  late List<BantuanOrderModel> orders;

  GetBantuanOrderHelperResponseModel.fromJson(ResponseModel response) {
    var data = response.data;

    orders = data.map<BantuanOrderModel>((bantuan) => BantuanOrderModel.fromJson(bantuan)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "orders": orders.map((bantuan) => bantuan.toJson()).toList()
    };
  }
}