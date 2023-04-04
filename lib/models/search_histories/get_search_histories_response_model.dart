import 'package:bantuin/models/main_model/respose_model.dart';
import 'package:bantuin/models/search_history_model.dart';

class GetSearchHistoriesResponseModel {
  late List<SearchHistoryModel> histories;

  GetSearchHistoriesResponseModel.fromJson(ResponseModel response) {
    var data = response.data;

    histories = data['search'].map<SearchHistoryModel>((history) => SearchHistoryModel.fromJson(history)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "histories": histories
    };
  }
}