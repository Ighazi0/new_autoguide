class BannerModel {
  String? id;
  String? image;
  String? title;
  String? storeId;
  String? nahmiId;
  String? userId;
  String? groupId;
  String? postId;
  String? sooqId;
  String? link;
  List<dynamic>? viewed;
  List<dynamic>? clicked;

  BannerModel({
    this.id,
    this.image,
    this.title,
    this.storeId,
    this.nahmiId,
    this.userId,
    this.groupId,
    this.postId,
    this.sooqId,
    this.link,
    this.clicked,
    this.viewed,
  });

  factory BannerModel.fromJson(Map json) => BannerModel(
    id: json['id'] as String?,
    image: json['image'] as String?,
    title: json['title'] as String?,
    storeId: json['storeId'] as String?,
    nahmiId: json['nashmiId'] as String?,
    userId: json['userId'] as String?,
    link: json['link'] as String?,
    clicked: (json['clicked'] as List?)?.cast<dynamic>(),
    viewed: (json['viewed'] as List?)?.cast<dynamic>(),
    groupId: json['groupId'] as String?,
    postId: json['postId'] as String?,
    sooqId: json['sooqId'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'title': title,
    'storeId': storeId,
    'nashmiId': nahmiId,
    'userId': userId,
    'link': link,
    'clicked': clicked,
    'viewed': viewed,
    'groupId': groupId,
    'postId': postId,
    'sooqId': sooqId,
  };
}
