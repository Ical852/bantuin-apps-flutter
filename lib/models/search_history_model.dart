class SearchHistoryModel {
  late int id, userId;
  late String searchText, createdAt, updatedAt;

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    searchText = json['search_text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "search_text": searchText,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}