class BantuanCategoryModel {
  late int id;
  late String name;

  BantuanCategoryModel(int id, String name) {
    this.id = id;
    this.name = name;
  }

  BantuanCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name
    };
  }
}