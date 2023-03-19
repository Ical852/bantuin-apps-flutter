class MetaModel {
  late int code;
  late String status;
  dynamic message;

  MetaModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "status": status,
      "message": message
    };
  }
}