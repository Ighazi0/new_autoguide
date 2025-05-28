import 'package:autoguide/models/group_model.dart';
import 'package:autoguide/models/media_model.dart';
import 'package:autoguide/models/user_model.dart';

class PostModel {
  final int? like;
  final int? comments;
  final int? shares;
  final String? address;
  final String? caption;
  final String? id;
  final String? timestamp;
  final String? link;
  final String? type;
  final String? uid;
  final bool? promote;
  final List<String>? likes;
  final List<String>? saves;
  final List<String>? views;
  final List<String>? hashtags;
  final List<MediaModel>? media;
  final UserModel? userData;
  final GroupModel? groupData;

  PostModel({
    this.like,
    this.comments,
    this.shares,
    this.address,
    this.caption,
    this.id,
    this.timestamp,
    this.link,
    this.type,
    this.uid,
    this.promote,
    this.likes,
    this.saves,
    this.views,
    this.hashtags,
    this.media,
    this.userData,
    this.groupData,
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
      'likes': likes ?? [],
      'saves': saves ?? [],
      'views': views ?? [],
      'hashtags': hashtags ?? [],
      'media': media?.map((e) => e.toJson()).toList() ?? [],
      'userData': userData?.toJson(),
      'groupData': groupData?.toJson(),
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      like: json['like'] as int?,
      comments: json['comments'] as int?,
      shares: json['shares'] as int?,
      address: json['address'] as String?,
      caption: json['caption'] as String?,
      id: json['id'] as String?,
      timestamp: json['timestamp'] as String?,
      link: json['link'] as String?,
      type: json['type'] as String?,
      uid: json['uid'] as String?,
      promote: json['promote'] as bool?,
      likes: (json['likes'] as List?)?.map((e) => e.toString()).toList(),
      saves: (json['saves'] as List?)?.map((e) => e.toString()).toList(),
      views: (json['views'] as List?)?.map((e) => e.toString()).toList(),
      hashtags: (json['hashtags'] as List?)?.map((e) => e.toString()).toList(),
      media: (json['media'] as List?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userData: json['userData'] != null
          ? UserModel.fromJson(json['userData'] as Map<String, dynamic>)
          : null,
      groupData: json['groupData'] != null
          ? GroupModel.fromJson(json['groupData'] as Map<String, dynamic>)
          : null,
    );
  }
}
