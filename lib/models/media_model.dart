class MediaModel {
  String? id;
  String? path;
  String thumbnail;
  bool? video;
  double? h;
  double? w;

  MediaModel({
    this.id = '',
    this.path = '',
    this.thumbnail = '',
    this.video = false,
    this.h,
    this.w,
  });

  Map<String, dynamic> toJson() {
    return {'path': path, 'id': id, 'thumbnail': thumbnail};
  }

  factory MediaModel.fromJson(Map json) {
    return MediaModel(
      path: json['path'],
      id: json['id'],
      thumbnail: json['thumbnail'],
      h: double.tryParse(json['h'].toString()),
      w: double.tryParse(json['w'].toString()),
    );
  }
}
