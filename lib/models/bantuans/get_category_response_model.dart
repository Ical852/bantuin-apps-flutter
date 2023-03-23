import 'package:bantuin/models/bantuan_category_model.dart';
import 'package:bantuin/models/main_model/respose_model.dart';

class GetCategoryResponseModel {
  late List<BantuanCategoryModel> categories;

  GetCategoryResponseModel.fromJson(ResponseModel response) {
    var data = response.data;

    categories = data.map<BantuanCategoryModel>((bantuan) => BantuanCategoryModel.fromJson(bantuan)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "categories": categories.map((bantuan) => bantuan.toJson()).toList()
    };
  }
}