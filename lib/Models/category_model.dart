class CategoryModel {
  String icon, text;

  CategoryModel.fromJason(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    icon = map['icon'];
    text = map['text'];
  }
}