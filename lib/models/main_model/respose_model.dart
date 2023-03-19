import 'package:bantuin/models/main_model/meta_model.dart';

class ResponseModel {
  late MetaModel meta ;
  dynamic data;

  ResponseModel.fromJson(Map<String, dynamic> json) {
    meta = MetaModel.fromJson(json['meta']);
    data = json['data'];
  }
}