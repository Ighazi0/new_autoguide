class CarModel {
  String id;
  String name;
  String brand;
  String model;
  String color;
  String profile;
  String cover;
  String year;
  String image;

  CarModel({
    this.id = '',
    this.name = '',
    this.brand = '',
    this.model = '',
    this.color = '',
    this.year = '',
    this.profile = '',
    this.cover = '',
    this.image = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'color': color,
      'profile': profile,
      'cover': cover,
      'year': year,
      'image': image,
    };
  }

  factory CarModel.fromJson(Map<dynamic, dynamic> json) {
    return CarModel(
      id: json['id'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      year: json['year'] ?? '',
      color: json['color'] ?? '',
      profile: json['profile'] ?? '',
      cover: json['cover'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
