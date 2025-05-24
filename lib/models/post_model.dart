import 'package:autoguide/models/user_model.dart';

class PostModel {
  int like;
  int comments;
  int shares;
  String address;
  String caption;
  String id;
  String timestamp;
  String link;
  String type;
  String uid;
  // MediaModel? videos;
  bool promote;
  bool video;
  List? likes;
  List? saves;
  List? views;
  List? hashtags;
  // List<MediaModel>? media;
  UserModel? userData;
  // GroupModel? groupData;

  PostModel({
    this.id = '',
    this.timestamp = '',
    this.like = 0,
    this.comments = 0,
    this.shares = 0,
    this.type = '',
    this.uid = '',
    this.link = '',
    this.address = '',
    this.caption = '',
    this.promote = false,
    this.video = false,
    this.likes,
    this.views,
    this.saves,
    this.hashtags,
    this.userData,
    // this.groupData,
  });

  Map<String, dynamic> toJson() {
    return {
      'like': like,
      'comments': comments,
      'shares': shares,
      'address': address,
      'caption': caption,
      'id': id,
      'timestamp': timestamp,
      'link': link,
      'type': type,
      'uid': uid,
      'promote': promote,
      'video': video,
      'saves': saves ?? [],
      'likes': likes ?? [],
      'views': views ?? [],
      'hashtags': hashtags ?? [],
      // 'videos': videos?.toJson(),
      // 'media': media!.map((e) => e.toJson()).toList(),
      'userData': userData!.toJson(),
      // 'groupData': groupData?.toJson(),
    };
  }

  factory PostModel.fromJson(Map json) {
    // List m = json['media'] ?? [];
    return PostModel(
      like: json['like'] ?? 0,
      comments: json['comments'] ?? 0,
      shares: json['shares'] ?? 0,
      address: json['address'] ?? '',
      caption: json['caption'] ?? '',
      id: json['id'] ?? '',
      timestamp: json['timestamp'] ?? '',
      link: json['link'] ?? '',
      saves: json['saves'] ?? [],
      type: json['type'] ?? '',
      uid: json['uid'] ?? '',
      promote: json['promote'] ?? false,
      likes: json['likes'] ?? [],
      views: json['views'] ?? [],
      hashtags: json['hashtags'] ?? [],
      // videos: MediaModel.fromJson(
      //   json['videos'] == null ? {} : json['videos'] as Map,
      // ),
      // media: m.map((e) => MediaModel.fromJson(e as Map)).toList(),
      userData:
          json['userData'] == null
              ? null
              : UserModel.fromJson(json['userData'] as Map),
      // groupData:
      //     json['groupData'] == null
      //         ? null
      //         : GroupModel.fromJson(json['groupData'] as Map),
    );
  }
}
