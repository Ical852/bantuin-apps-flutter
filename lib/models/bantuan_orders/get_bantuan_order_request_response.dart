import 'package:bantuin/models/bantuan_order_model.dart';
import 'package:bantuin/models/main_model/respose_model.dart';

class GetBantuanOrderRequestResponse {
  late List<BantuanOrderModel> bantuanOrders;

  GetBantuanOrderRequestResponse.fromJson(ResponseModel response) {
    var data = response.data;

    bantuanOrders = data.map<BantuanOrderModel>((bantuan) => BantuanOrderModel.fromJson(bantuan)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "bantuan_orders": bantuanOrders.map((bantuan) => bantuan.toJson()).toList()
    };
  }
}