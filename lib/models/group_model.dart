class GroupModel {
  String id;
  String uid;
  String timestamp;
  String name;
  String description;
  String cover;
  String link;
  bool verified;
  List? members;
  List? tags;

  GroupModel({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.link = '',
    this.timestamp = '',
    this.description = '',
    this.cover = '',
    this.verified = false,
    this.members,
    this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'timestamp': timestamp,
      'name': name,
      'description': description,
      'cover': cover,
      'link': link,
      'verified': verified,
      'members': members,
      'tags': tags,
    };
  }

  factory GroupModel.fromJson(Map<dynamic, dynamic> json) {
    return GroupModel(
      id: json['id'] ?? '',
      uid: json['uid'] ?? '',
      link: json['link'] ?? '',
      timestamp: json['timestamp'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      cover: json['cover'] ?? '',
      verified: json['verified'] ?? false,
      members: json['members'] ?? [],
      tags: json['tags'] ?? [],
    );
  }
}
