class CategoryModel {
  final String id;
  final List<CategoryModel>? sub;
  final String type;
  String image;
  final String name;
  final String nameAr;
  final String nameEn;
  final List<String>? tags;
  final List<String>? items;
  final int sort;

  CategoryModel(
      {this.type = '',
      this.id = '',
      this.image = '',
      this.name = '',
      this.nameAr = '',
      this.nameEn = '',
      this.sub,
      this.tags,
      this.sort = 0,
      this.items});

  factory CategoryModel.fromJson(Map json) {
    return CategoryModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      nameAr: json['nameAr']??'',
      nameEn: json['nameEn']??'',
      sub: json['sub'] != null
          ? (json['sub'] as List).map((i) => CategoryModel.fromJson(i)).toList()
          : [],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => i.toString()).toList()
          : [],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      sort: json['sort'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'image': image,
      'name': name,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'sub': sub?.map((i) => i.toJson()).toList(),
      'items': items,
      'tags': tags,
      'sort': sort,
    };
  }
}
