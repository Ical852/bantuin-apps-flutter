import 'package:bantuin/models/helper_rate_model.dart';
import 'package:bantuin/models/main_model/respose_model.dart';

class GetAllHelperRateResponseModel {
  late List<HelperRateModel> rates;

  GetAllHelperRateResponseModel.fromJson(ResponseModel response) {
    var data = response.data;

    rates = data['rate'].map<HelperRateModel>((rate) => HelperRateModel.fromJson(rate)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "rates": rates.map((rate) => rate.toJson()).toList()
    };
  }
}