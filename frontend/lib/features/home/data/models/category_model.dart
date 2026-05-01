import 'package:shop_demo/features/home/domain/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.iconUrl,
    super.isNew,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String? ?? json['icon_url'] as String? ?? '',
      isNew: json['isNew'] as bool? ?? json['is_new'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconUrl': iconUrl,
      'isNew': isNew,
    };
  }

  static List<CategoryModel> listFromJson(List<dynamic> json) {
    return json
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
